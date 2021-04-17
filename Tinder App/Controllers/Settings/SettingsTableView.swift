//
//  SettingsTavleView.swift
//  Tinder App
//
//  Created by Kingsley Charles on 17/04/2021.
//

import Foundation
import UIKit

extension SettingsController  {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 0 : 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  SettingsViewCell(style: .default, reuseIdentifier: nil)
        let settingsTextfield = cell.settingsInputField
        settingsTextfield.addTarget(self, action: #selector(userChangeRequest), for: .editingChanged)
        cell.selectionStyle = .none
        switch indexPath.section{
        case 1:
            settingsTextfield.placeholder = "Enter Name"
            settingsTextfield.text = user?.name
        case 2:
            settingsTextfield.placeholder = "Enter Profession"
        case 3:
            settingsTextfield.placeholder = "Enter Age"
        case 4:
            settingsTextfield.placeholder = "Enter Bio"
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
    
    @objc private func userChangeRequest(sender: UITextField) {
        let textfieldId = sender.placeholder
        switch textfieldId {
        case "Enter Name":
            user?.name = sender.text ?? ""
        case "Enter Profession":
            user?.profession = sender.text ?? ""
            
        case "Enter Age":
            user?.age = sender.text ?? ""
            
//        case "Enter Bio":
//        user?.bio = sender.text ?? ""
        
        default:
            break
        }
    }
}
