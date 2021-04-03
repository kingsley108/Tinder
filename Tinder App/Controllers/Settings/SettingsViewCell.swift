//
//  SettingsViewCell.swift
//  Tinder App
//
//  Created by Kingsley Charles on 03/04/2021.
//

import UIKit

class SettingsViewCell: UITableViewCell {
    
    lazy var settingsInputField: SettingsTextField = {
        let settingsField = SettingsTextField()
        settingsField.isUserInteractionEnabled = true
        return settingsField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        self.setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setUpView() {
        addSubview(settingsInputField)
        settingsInputField.fillToSuperView()
    }

}
