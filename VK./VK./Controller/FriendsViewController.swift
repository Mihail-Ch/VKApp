//
//  FriendsViewController.swift
//  VK.
//
//  Created by Михаил Чертов on 26.01.2021.
//

import UIKit

class FriendsViewController: UIViewController {

    //MARK: - Variables
    
    lazy var vkApi = VKApi()
    var friends = [User]()
    var sections = [Section<User>]()
    
    
    //MARK: - Outlet
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
            searchBar.placeholder = "Поиск"
           
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.separatorStyle = .none
        }
    }
    
    //MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
       
        vkApi.getFriends { [weak self] friend in
            self?.friends = friend
            self?.makeSortedSection()
            self?.tableView.reloadData()
        }
        
        
        title()
        updateBackItem()
        makeSortedSection()
        tableView.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.reuseId)
    }
    
    //MARK: - UpdateTableView
    
    func title() {
        navigationItem.title = "Друзья"
    }

    func updateBackItem() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
    }
    
    func makeSortedSection() {
        let friendsDictionary = Dictionary.init(grouping: friends) { $0.lastName.prefix(1) }
        sections = friendsDictionary.map{ Section(letter: String($0.key), names: $0.value) }
        sections.sort { $0.letter < $1.letter }
    }
}

//MARK: - DataSource

extension FriendsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return sections[section].letter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let friend = sections[indexPath.section]
        cell.label.text = friend.names[indexPath.row].firstName + " " + friend.names[indexPath.row].lastName
        cell.avatar.downloadImage(urlPath: friend.names[indexPath.row].avatar)
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            friends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].letter
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections.map { $0.letter }
    }
}

//MARK: - TableViewDelegate

extension FriendsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selected = friends[indexPath.row]
        let vc = storyboard?.instantiateViewController(identifier: "FriendsPhotoViewControllerKey") as! FriendsPhotoViewController
        vc.photo = selected
        self.show(vc, sender: nil)
        
    }
}

//MARK: - SearchBarDelegate

extension FriendsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let friendsDictionary = Dictionary.init(grouping: friends.filter{ (user) -> Bool in
            return searchText.isEmpty ? true : user.lastName.lowercased().contains(searchText.lowercased())
        }) {$0.lastName.prefix(1)}
        sections = friendsDictionary.map { Section(letter: String($0.key), names: $0.value) }
        sections.sort { $0.letter < $1.letter }
        tableView.reloadData()

        }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        print("Search button clicked")
    }
}
