//
//  AllGroupViewController.swift
//  VK.
//
//  Created by Михаил Чертов on 26.01.2021.
//

import UIKit

class AllGroupViewController: UIViewController {

    //MARK: - Variables
    var sections = [Section<GroupItems>]()
    var groups = [GroupItems]()
    var vkApi = VKApi()
   
    
    
    
    
    //MARK: - Outlet
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
            searchBar.placeholder = "Поиск"
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
           //tableView.dataSource = self
           tableView.delegate = self
        }
    }
    
    //MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeSortedSection()
        tableView.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.reuseId)
    }
    
    func makeSortedSection() {
        let groupsDictionary = Dictionary.init(grouping: groups) {
           $0.name.prefix(1)}
        sections = groupsDictionary.map { Section(letter: String($0.key), names: $0.value) }
        sections.sort { $0.letter < $1.letter }
    }
}

//MARK: - DataSource

extension AllGroupViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].letter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let group = sections[indexPath.section]
        cell.label.text = group.names[indexPath.row].name
        cell.avatar.downloadImage(urlPath: group.names[indexPath.row].avatar)
        
        return cell
    }
    
    // MARK: - Navigation

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "AddGroup", sender: nil)
        }
}

//MARK: - SearchBarDelegate

extension AllGroupViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let groupsDictionary = Dictionary.init(grouping: groups.filter{ (group) -> Bool in
            return searchText.isEmpty ? true : group.name.lowercased().contains(searchText.lowercased())
        }) {$0.name.prefix(1)}
        sections = groupsDictionary.map { Section(letter: String($0.key), names: $0.value) }
        sections.sort { $0.letter < $1.letter }
        vkApi.searchGetGroups(searchText: searchText) { [weak self] group in
            self?.groups = group
            self?.tableView.reloadData()
        }
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        
    }
    
}

//MARK: - Delegate

extension AllGroupViewController: UITableViewDelegate {
    
}




