//
//  ViewController.swift
//  Tinder App
//
//  Created by Kingsley Charles on 16/03/2021.
//

import UIKit
import Foundation
import FirebaseFirestore
import JGProgressHUD

class HomeController: UIViewController {
    lazy var hud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Registering"
        hud.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 5.0, opacity: 0.1)
        return hud
    }()
    
    var users = [CardViewModel]()
    let cardContainer = SwipeablePhotoCardView()
    var lastFetchedUser: User? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpViews()
        fetchUsers()
    }
    
    fileprivate func fetchUsers() {
        let db = Firestore.firestore()
        var query = db.collection("users").order(by: "uid").limit(to: 2)
        if let last = lastFetchedUser?.uid {
            query = query.start(after: [last])
        }
        query.getDocuments { (snapshot, err) in
            if let err = err {
                print(err)
                return
            }
            self.hud.dismiss()
            guard let snap = snapshot else {return }
            let documents = snap.documents
            documents.forEach({ doc in
                if let dict = doc.data() as? [String: Any] {
                    guard let name = dict["fullname"] as? String else {return}
                    guard let imageUrl = dict["imageUrl"] as? String else {return}
                    guard let uid = dict["uid"] as? String else {return}
                    let user = User(name: name, age: nil, imageProfiles: imageUrl, profession: nil, uid: uid)
                    self.lastFetchedUser = user
                    self.users.append(user.convertToCardModel())
                    self.setUpCards(user: user.convertToCardModel())
                }
            })
        }
    }
    fileprivate func setUpCards(user: CardViewModel) {
        let swipeableUser = SwipeablePhotoCardView()
        swipeableUser.cardObject = user
        cardContainer.addSubview(swipeableUser)
        cardContainer.sendSubviewToBack(swipeableUser)
        swipeableUser.fillToSuperView()
    }
    
//    fileprivate func setUpCardView() {
//        users.forEach { (user) in
//            let swipeableUser = SwipeablePhotoCardView()
//            swipeableUser.cardObject = user
//            cardContainer.addSubview(swipeableUser)
//            swipeableUser.fillToSuperView()
//        }
//    }
    
    
    fileprivate func setUpViews() {
        let topView = TopInteractionStackView()
        topView.delegate = self
        
        let bottomView = HomeClassStackView()
        bottomView.refreshButton.addTarget(self, action: #selector(refreshView), for: .touchUpInside)
        let stackView = UIStackView(arrangedSubviews: [topView,cardContainer,bottomView])
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor,trailing: view.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor)
        
        topView.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, size: .init(width: 100, height: 100))
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
        stackView.bringSubviewToFront(cardContainer)
    }

    @objc fileprivate func refreshView() {
        hud.show(in: self.view)
        fetchUsers()
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
