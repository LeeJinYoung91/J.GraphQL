//
//  UserListTableViewController.swift
//  J.UserManagerment
//
//  Created by JinYoung Lee on 2020/03/24.
//  Copyright © 2020 JinYoung Lee. All rights reserved.
//

import Foundation
import UIKit
import Apollo

class UserListTableViewController: UITableViewController {
    var watcher: GraphQLQueryWatcher<AllUserQuery>?
    private var userList: [User] = [User]()
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
        setNavigationBar()
    }
    
    private func setNavigationBar() {
        navigationItem.title = "User List"
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(presentAddItemAlertView))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func presentAddItemAlertView() {
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        ac.addTextField { (textField) in
            textField.placeholder = "Age"
        }
        ac.addTextField { (textField) in
            textField.placeholder = "Gender"
        }
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [unowned ac] _ in
            guard let name = ac.textFields![0].text else {
                return
            }
            
            guard let ageText = ac.textFields![1].text, let age = Int(ageText) else {
                return
            }
            
            guard let gender = ac.textFields![2].text else {
                return
            }
            
            Network.shared.apollo.perform(mutation: CreateUserMutation(name: name, age: age, gender: gender)) { result in
                let _ = result.mapError({ (err) -> Error in
                    print(err.localizedDescription)
                    return err
                })
                guard let _ = try? result.get().data else { return }
                self.loadData()
            }
        }
        
        ac.addAction(submitAction)
        
        present(ac, animated: true)
    }
    
    private func loadData() {
        Network.shared.apollo.clearCache()
        watcher = Network.shared.apollo.watch(query: AllUserQuery()) { [unowned self] result in
            self.userList.removeAll()
            switch result {
            case .success(let graphQLResult):
                guard let data = graphQLResult.data else {
                    return
                }
                
                for user in data.users {
                    self.userList.append(User(id: user.fragments.userDetail.id, name: user.fragments.userDetail.name, age: user.fragments.userDetail.age, gender: user.fragments.userDetail.gender))
                }
                
                self.tableView.reloadData()
            case .failure(let error):
                NSLog("Error while fetching query: \(error.localizedDescription)")
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = tableView.dequeueReusableCell(withIdentifier: "userListCell", for: indexPath) as? UserListCell
        userCell?.setUp(user: userList[indexPath.row])
        return userCell == nil ? UITableViewCell() : userCell!
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let user = userList[indexPath.row]
            let id = user._id!
            
            Network.shared.apollo.perform(mutation: DeleteUserMutation(id: id)) { result in
                self.userList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        }
    }
}
