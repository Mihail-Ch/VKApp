//
//  FriendsViewController.swift
//  VK.
//
//  Created by Михаил Чертов on 26.01.2021.
//

import UIKit
import RealmSwift


class FriendsViewController: UIViewController {
    

    //MARK: - Variables
    
    lazy var vkApi = VKApi()
    var friend = [User]()
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
        
        loadFromRealm()
       
        vkApi.getFriends { [weak self] in
            self?.loadFromRealm()
        }
        
        title()
        updateBackItem()
        makeSortedSection()
        tableView.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.reuseId)
    }
    
    //MARK: - Realm
    
    private func loadFromRealm() {
        let realm = try! Realm()
        let friends = realm.objects(User.self)
        friend = Array(friends)
        makeSortedSection()
        tableView.reloadData()
        
    }
    
    //MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let controller = segue.destination as? FriendsPhotoViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
        let item = sections[indexPath.section]
        let user = item.names[indexPath.row]
        controller.title = user.fullName
        controller.friendId = user.id
    }
    
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowPhoto", sender: nil)
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
        let friendsDictionary = Dictionary.init(grouping: friend) { $0.lastName.prefix(1) }
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
        let friend = sections[indexPath.section].names[indexPath.row]
        let url = URL(string: friend.avatar)
        cell.configure(name: friend.fullName, avatar: url)
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            friend.remove(at: indexPath.row)
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

extension FriendsViewController: UITableViewDelegate { }

//MARK: - SearchBarDelegate

extension FriendsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let friendsDictionary = Dictionary.init(grouping: friend.filter{ (user) -> Bool in
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
