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
        let ageCell = AgeRangeCell(style: .default, reuseIdentifier: nil)
        ageCell.maxAgeSlider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        ageCell.minAgeSlider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        settingsTextfield.addTarget(self, action: #selector(userChangeRequest), for: .editingChanged)
        cell.selectionStyle = .none
        switch indexPath.section{
        case 1:
            settingsTextfield.placeholder = "Enter Name"
            settingsTextfield.text = user?.name
        case 2:
            settingsTextfield.text = user?.profession
            settingsTextfield.placeholder = "Enter Profession"
        case 3:
            if let age = self.user?.age {
                settingsTextfield.text = String("\(age.toString())")
            }
            settingsTextfield.placeholder = "Enter Age"
        case 4:
            settingsTextfield.placeholder = "Enter Bio"
        case 5:
            ageCell.maxAgeSlider.value = Float(user?.maxAge ?? 20)
            ageCell.maxAgeRange.text =  String(format: "Max: %i",Int(ageCell.maxAgeSlider.value))
            ageCell.minAgeSlider.value = Float(user?.minAge ?? 18)
            ageCell.minAgeRange.text = String(format: "Min: %i",Int(ageCell.minAgeSlider.value))
            return ageCell
        default:
            break
        }
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 6
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
        case 5:
            headerCell.text = "Seeking Age Range"
        default:
            headerCell.text = ""
        }
        return headerCell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 300 : 40
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  indexPath.section == 5 ? 100 : 40
    }
}
