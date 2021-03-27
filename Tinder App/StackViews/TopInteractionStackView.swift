//
//  TopInteractionStackView.swift
//  Tinder App
//
//  Created by Kingsley Charles on 16/03/2021.
//

import UIKit
import Foundation

protocol LogOutInteraction {
    func logOutUser()
}

class TopInteractionStackView: UIStackView {
    var delegate: LogOutInteraction?
    var profileButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "top_left_profile"), for: .normal)
        btn.contentMode = .scaleAspectFill
        btn.addTarget(self, action: #selector(settingsAction), for: .touchUpInside)
        return btn
    }()
    
    var chatIcon: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "top_right_messages"), for: .normal)
        btn.contentMode = .scaleAspectFill
        return btn
    }()
    
    var flameIcon: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "app_icon"), for: .normal)
        btn.contentMode = .scaleAspectFill
        return btn
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    fileprivate func setUpViews() {
        distribution = .equalCentering
        [profileButton,UIView(),flameIcon,UIView(),chatIcon].forEach { (btn) in
            addArrangedSubview(btn)
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc fileprivate func settingsAction() {
        delegate?.logOutUser()
    }
    
    

}
