//
//  SettingsHeaderView.swift
//  Tinder App
//
//  Created by Kingsley Charles on 03/04/2021.
//

import UIKit

protocol SettingsViewProtocol {
    func didChangeSettingsProfile(for: UIButton)
}

class SettingsHeaderView: UIView {
    
    var delegate: SettingsViewProtocol?
    
    lazy var mainDisplayImage1: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("Select Photo", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.layer.cornerRadius = 12
        btn.clipsToBounds = true
        btn.tag = 1
        btn.imageView?.contentMode = .scaleAspectFill
        btn.titleLabel?.textAlignment = .center
        btn.accessibilityIdentifier = "Button 1"
        btn.addTarget(self, action: #selector(setButtonImage), for: .touchUpInside)
        return btn
    }()
    
    lazy var alternateDisplayImage1: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("Select Photo", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.layer.cornerRadius = 12
        btn.clipsToBounds = true
        btn.imageView?.contentMode = .scaleAspectFill
        btn.titleLabel?.textAlignment = .center
        btn.tag = 2
        btn.accessibilityIdentifier = "Button 2"
        btn.addTarget(self, action: #selector(setButtonImage), for: .touchUpInside)
        return btn
    }()
    
    lazy var alternateDisplayImage2: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .white
        btn.setTitle("Select Photo", for: .normal)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.layer.cornerRadius = 12
        btn.clipsToBounds = true
        btn.imageView?.contentMode = .scaleAspectFill
        btn.titleLabel?.textAlignment = .center
        btn.tag = 3
        btn.accessibilityIdentifier = "Button 3"
        btn.addTarget(self, action: #selector(setButtonImage), for: .touchUpInside)
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setUpViews()
        setUpStackView()
    }
    
    fileprivate func addSubviews() {
        addSubview(mainDisplayImage1)
        addSubview(alternateDisplayImage1)
        addSubview(alternateDisplayImage2)
    }
    
    fileprivate func setUpViews() {
        mainDisplayImage1.anchor(top: topAnchor, leading: leadingAnchor, trailing: nil, bottom: bottomAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 0))
        mainDisplayImage1.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45).isActive = true
    }
    
    fileprivate func setUpStackView() {
        let stackView = UIStackView(arrangedSubviews: [alternateDisplayImage1, alternateDisplayImage2])
        addSubview(stackView)
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.anchor(top: topAnchor, leading: mainDisplayImage1.trailingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, padding: .init(top: 12, left: 12, bottom: 0, right: 12))
    }
    
    @objc fileprivate func setButtonImage(sender: UIButton) {
        delegate?.didChangeSettingsProfile(for: sender)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
