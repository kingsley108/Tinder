//
//  ViewController.swift
//  Tinder App
//
//  Created by Kingsley Charles on 16/03/2021.
//

import UIKit

class HomeController: UIViewController {
    
    let users = [User(name: "Jane", age: 18, imageProfile: #imageLiteral(resourceName: "jane1"), profession: "Teacher"), User(name: "Kelly", age: 23, imageProfile: #imageLiteral(resourceName: "lady5c"), profession: "Muisc DJ")]
    let cardContainer = SwipeablePhoto()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpViews()
        setUpCardView()
    }
    
    fileprivate func setUpCardView() {
        users.forEach { (user) in
            let swipeableUser = SwipeablePhoto()
            swipeableUser.photoView.image = user.imageProfile
            let attributedString = NSMutableAttributedString(string: user.name!, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 35)])
            attributedString.append(NSAttributedString(string: "  "))
            attributedString.append(NSAttributedString(string: "\(user.age ?? 0)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
            attributedString.append(NSAttributedString(string: "\n \(user.profession ?? "")" , attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
            swipeableUser.userDetails.attributedText = attributedString
            cardContainer.addSubview(swipeableUser)
            swipeableUser.fillToSuperView()
            
        }
        
    }
    
    
    
    fileprivate func setUpViews() {
  
        let topView = TopInteractionStackView()
        
        let yellowView = HomeClassStackView()
        let stackView = UIStackView(arrangedSubviews: [topView,cardContainer,yellowView])
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor,trailing: view.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor)
       
        topView.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, size: .init(width: 100, height: 100))

        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
        stackView.bringSubviewToFront(cardContainer)
    }

}
