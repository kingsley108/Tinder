//
//  ViewController.swift
//  Tinder App
//
//  Created by Kingsley Charles on 16/03/2021.
//

import UIKit

class HomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpViews()
    }
    
    fileprivate func setUpViews() {
  
        let topView = TopInteractionStackView()
        let userPhoto = SwipeablePhoto()
        userPhoto.photoView.image = #imageLiteral(resourceName: "lady5c")
        let yellowView = HomeClassStackView()
        let stackView = UIStackView(arrangedSubviews: [topView,userPhoto,yellowView])
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor,trailing: view.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor)
       
        topView.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, size: .init(width: 100, height: 100))

        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
        stackView.bringSubviewToFront(userPhoto)
    }

}
