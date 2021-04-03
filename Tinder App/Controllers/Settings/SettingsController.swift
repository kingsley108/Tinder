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
        tableView.backgroundColor = .systemGray5
        tableView.keyboardDismissMode = .interactive
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
        navigationItem.rightBarButtonItems = [saveButton, logoutButton]

    }
    
     func didChangeSettingsProfile(for sender: UIButton) {
        self.sender = sender
        self.getPhotoAsset()
    }
    
    @objc fileprivate func dismissView() {
        
    }
    
    @objc fileprivate func saveSettings() {
        
    }
    
    @objc fileprivate func logoutSettings() {
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return section == 0 ? 0 : 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  SettingsViewCell(style: .default, reuseIdentifier: nil)
        cell.selectionStyle = .none
        switch indexPath.section{
        case 1:
            cell.settingsInputField.placeholder = "Enter Name"
        case 2:
            cell.settingsInputField.placeholder = "Enter Profession"
        case 3:
            cell.settingsInputField.placeholder = "Enter Age"
        case 4:
            cell.settingsInputField.placeholder = "Enter Bio"
        default:
            break
        }
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = SettingsHeaderView()
            headerView.delegate = self
            return headerView
        }
        
        let headerCell = SettingsGroupHeaderLabel()
        switch section {
        case 1:
            headerCell.text = "Name"
        case 2:
            headerCell.text = "Profession"
        case 3:
            headerCell.text = "Age"
        case 4:
            headerCell.text = "Bio"
        default:
            headerCell.text = ""
        }
        return headerCell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 300 : 40
    }
}
