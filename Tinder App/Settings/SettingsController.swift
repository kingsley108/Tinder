//
//  SettingsController.swift
//  Tinder App
//
//  Created by Kingsley Charles on 31/03/2021.
//

import UIKit

class SettingsController: UITableViewController, SettingsViewProtocol {
    
    var sender: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .lightGray
        setUpNavigation()
    }
    
    fileprivate func setUpNavigation () {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.tableView.separatorStyle = .none
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Settings"
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissView))
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutSettings))
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveSettings))
        navigationItem.leftBarButtonItem = cancel
        navigationItem.rightBarButtonItems = [logoutButton, saveButton]
    }
    
    @objc fileprivate func dismissView() {
        
    }
    
    @objc fileprivate func saveSettings() {
        
    }
    
    @objc fileprivate func logoutSettings() {
        
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = SettingsHeaderView()
        headerView.delegate = self
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 300
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */
    
    func didChangeSettingsProfile(for sender: UIButton) {
        self.sender = sender
        self.getPhotoAsset()
    }
}
