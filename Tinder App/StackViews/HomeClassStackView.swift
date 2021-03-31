//
//  HomeClassStackView.swift
//  Tinder App
//
//  Created by Kingsley Charles on 16/03/2021.
//

import UIKit
import Foundation

class HomeClassStackView: UIStackView {

    lazy var refreshButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "refresh_circle"), for: .normal)
        return btn
    }()
    
    lazy var exitButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "dismiss_circle"), for: .normal)
        return btn
    }()
    
    lazy var starButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "super_like_circle"), for: .normal)
        return btn
    }()
    
    lazy var loveButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "like_circle"), for: .normal)
        return btn
    }()
    
    lazy var flashButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "boost_circle"), for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    func setView() {
        let homeButonsStack = [refreshButton,exitButton,starButton,loveButton,flashButton].map { (button) -> UIButton in return button}
        
        homeButonsStack.forEach { (btn) in
            addArrangedSubview(btn)
        }
        
        distribution = .fillEqually
        anchor(top: nil, leading: nil, trailing: nil, bottom: nil, size: .init(width: 120, height: 120))
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
