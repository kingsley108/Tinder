//
//  ViewController.swift
//  Tinder App
//
//  Created by Kingsley Charles on 16/03/2021.
//

import UIKit
import Foundation

class HomeController: UIViewController {
    
    var users = ([User(name: "Jane", age: 18, imageProfiles: [#imageLiteral(resourceName: "jane1"), #imageLiteral(resourceName: "jane3"),#imageLiteral(resourceName: "jane2")], profession: "Teacher"), User(name: "Kelly", age: 23, imageProfiles: [#imageLiteral(resourceName: "lady5c"),#imageLiteral(resourceName: "kelly2"),#imageLiteral(resourceName: "kelly1")], profession: "Muisc DJ"), AdvertiserViewModels(brandName: "", imageAsset: [#imageLiteral(resourceName: "slide_out_menu_poster")])] as [ProducesCardViewModel]).map { (model) -> CardViewModel in
    model.convertToCardModel()
}
    
    
    let cardContainer = SwipeablePhotoCardView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpViews()
        setUpCardView()
        
    }
    
    fileprivate func setUpCardView() {
        self.users = users.reversed()
        users.forEach { (user) in
            let swipeableUser = SwipeablePhotoCardView()
            swipeableUser.cardObject = user
            cardContainer.addSubview(swipeableUser)
            swipeableUser.fillToSuperView()

        }

    }
    
    
    fileprivate func setUpViews() {
  
        let topView = TopInteractionStackView()
        topView.delegate = self
        
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

extension HomeController: LogOutInteraction {
    func logOutUser() {
        let registrationController = RegistrationController()
        let navigationController = UINavigationController(rootViewController: registrationController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
}
