//
//  AgeRangeCell.swift
//  Tinder App
//
//  Created by Kingsley Charles on 24/04/2021.
//

import UIKit
import Foundation

class AgeRangeCell: UITableViewCell {
    
    lazy var ageSliderStack: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 2
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var minimiumSliderStack: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var maximiumSliderStack: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .horizontal
        return stackView
    }()
    
    lazy var maxAgeRange: UILabel = {
        let lbl = UILabel()
        lbl.text = "Max: 18"
        return lbl
    }()
    
    lazy var minAgeRange: UILabel = {
        let lbl = UILabel()
        lbl.text = "Min: 18"
        return lbl
    }()
    
    lazy var maxAgeSlider: UISlider = {
        let slider = UISlider()
        slider.maximumValue = 50
        slider.minimumValue = 18
        slider.tag = 1
        return slider
    }()
    
    lazy var minAgeSlider: UISlider = {
        let slider = UISlider()
        slider.maximumValue = 50
        slider.minimumValue = 18
        slider.tag = 2
        return slider
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        addSubViews()
        setUpViews()
    }
    
    fileprivate func addSubViews() {
        
        addSubview(minimiumSliderStack)
        minimiumSliderStack.addArrangedSubview(minAgeRange)
        minimiumSliderStack.addArrangedSubview(minAgeSlider)
        addSubview(maximiumSliderStack)
        maximiumSliderStack.addArrangedSubview(maxAgeRange)
        maximiumSliderStack.addArrangedSubview(maxAgeSlider)
        addSubview(ageSliderStack)
        ageSliderStack.addArrangedSubview(maximiumSliderStack)
        ageSliderStack.addArrangedSubview(minimiumSliderStack)
    }
    
    fileprivate func setUpViews() {
        ageSliderStack.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, padding: UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
