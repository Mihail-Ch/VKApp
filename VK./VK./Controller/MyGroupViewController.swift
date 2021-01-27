//
//  MyGroupViewController.swift
//  VK.
//
//  Created by Михаил Чертов on 26.01.2021.
//

import UIKit

class MyGroupViewController: UIViewController {

    //MARK: - Variables
    var sections = [Section<GroupItems>]()
    var groups = [GroupItems]()
    lazy var vkApi = VKApi()
    
    //MARK: - Outlet
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView?.dataSource = self
            tableView?.delegate = self
        }
    }
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
            searchBar.placeholder = "Поиск"
        }
    }
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vkApi.getGroups { [weak self] group in
            self?.groups = group
            self?.makeSortedSection()
            self?.tableView.reloadData()
        }
        title()
        makeSortedSection()
        
    }
    
    //MARK: - Navigation
    
    @IBAction func unwindFromAllGroups(_ sender: UIStoryboardSegue) {
        guard let controller = sender.source as? AllGroupViewController,
              let indexPath = controller.tableView.indexPathForSelectedRow else {
            return
        }
        var group = controller.groups[indexPath.row].name
        if !group.contains(group) {
            group.append(group)
            tableView.reloadData()
        }
    }
    
    //MARK: - UpdateTableView
    
    func title() {
        navigationItem.title = "МоиГруппы"
    }
    
    func makeSortedSection() {
        let groupsDictionary = Dictionary.init(grouping: groups) {
           $0.name.prefix(1)}
        sections = groupsDictionary.map { Section(letter: String($0.key), names: $0.value) }
        sections.sort { $0.letter < $1.letter }
    }
}

//MARK: - DataSource

extension MyGroupViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].letter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let group = sections[indexPath.section]
    cell.configure(name: group.names[indexPath.row].name, avatar: UIImage(named: group.names[indexPath.row].avatar)!)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

//MARK: - SearchBarDelegate

extension MyGroupViewController: UISearchBarDelegate {
   
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let groupsDictionary = Dictionary.init(grouping: groups.filter{ (group) -> Bool in
            return searchText.isEmpty ? true :
                group.name.lowercased().contains(searchText.lowercased())
        }) {$0.name.prefix(1)}
        sections = groupsDictionary.map { Section(letter: String($0.key), names: $0.value) }
        sections.sort { $0.letter < $1.letter}
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        print("Search button clicked")
    }
}

//MARK: - Delegate

extension MyGroupViewController: UITableViewDelegate {
    



}


