//
//  SettingsGroupLabel.swift
//  Tinder App
//
//  Created by Kingsley Charles on 03/04/2021.
//

import UIKit

class SettingsGroupHeaderLabel: UILabel {
    var leftInset: CGFloat
    var rightInset: CGFloat
    var bottomInset: CGFloat
    var topInset: CGFloat
    
    required init(topInset: CGFloat, bottomInset: CGFloat, rightInset: CGFloat, leftInset: CGFloat) {
        super.init(frame: .zero)
        self.topInset = topInset
        self.bottomInset = bottomInset
        self.topInset = topInset
        self.leftInset = leftInset
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
