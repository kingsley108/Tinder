//
//  HomeClassStackView.swift
//  Tinder App
//
//  Created by Kingsley Charles on 16/03/2021.
//

import UIKit
import Foundation

class HomeClassStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    func setView() {
        let homeButonsStack = [#imageLiteral(resourceName: "refresh_circle"),#imageLiteral(resourceName: "dismiss_circle"),#imageLiteral(resourceName: "super_like_circle"),#imageLiteral(resourceName: "like_circle"),#imageLiteral(resourceName: "boost_circle")].map { (img) -> UIButton in
            let btn = UIButton()
            btn.setImage(img, for: .normal)
            return btn
        }
        
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
