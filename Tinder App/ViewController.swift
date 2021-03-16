//
//  ViewController.swift
//  Tinder App
//
//  Created by Kingsley Charles on 16/03/2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpViews()
    }
    
    fileprivate func setUpViews() {
        
       let redView = [UIColor.black, UIColor.gray, .darkGray].map { (color) -> UIView in
            let colorView = UIView()
            colorView.backgroundColor = color
            return colorView
        }
        
        let topView = UIStackView(arrangedSubviews: redView)
        topView.distribution = .fillEqually
        
        let blueView = UIView()
        blueView.backgroundColor = .blue

        let yellowView = UIView()
        yellowView.backgroundColor = .yellow
        let stackView = UIStackView(arrangedSubviews: [topView,blueView,yellowView])
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.fillToSuperView()
        yellowView.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, size: .init(width: 120, height: 120))
        topView.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, size: .init(width: 100, height: 100))

        
    }

}
