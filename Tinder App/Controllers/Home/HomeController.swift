//
//  ViewController.swift
//  Tinder App
//
//  Created by Kingsley Charles on 16/03/2021.
//

import UIKit
import Foundation
import FirebaseFirestore
import FirebaseAuth
import JGProgressHUD

class HomeController: UIViewController {
    let db = Firestore.firestore()
    let settingsHandler = SettingsController()
    let registrationDelegateHandler = RegistrationController()
    var users = [CardViewModel]()
    var currentUser: User?
    lazy var hud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Fetching Users"
        hud.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 5.0, opacity: 0.1)
        return hud
    }()
    let cardContainer = UIView()
    
    var lastFetchedUser: User? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpViews()
        fetchCurrentUser()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if Auth.auth().currentUser == nil {
            let loginController = LoginController()
            loginController.delegate = self
            settingsHandler.delegate = self
            registrationDelegateHandler.delegate = self
            let navigationController = UINavigationController(rootViewController: loginController)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true)
        }
    }
    
     func fetchUsers() {
        self.hud.show(in: self.view)
        guard let currentUser = self.currentUser else {return}
        if !self.users.isEmpty {
            self.users.removeAll()
            for subView in self.cardContainer.subviews  {
                subView.removeFromSuperview()
            }
        }
        
        var query = db.collection("users").whereField("age", isGreaterThanOrEqualTo: currentUser.minAge).whereField("age", isLessThanOrEqualTo: currentUser.maxAge)
        query = query.order(by: "age")
//        if let last = lastFetchedUser?.age {
//            query = query.start(after: [last])
//        }
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
                    let user = User(dict: dict)
                    let isNotCurrentUser = user.uid != currentUser.uid
                    if isNotCurrentUser {
                        self.lastFetchedUser = user
                        self.users.append(user.convertToCardModel())
                        self.setUpCards(user: user.convertToCardModel())
                    }
                }
            })
        }
    }
    
     func fetchCurrentUser() {
        guard let currentUserID = Auth.auth().currentUser?.uid else {return}
        db.collection("users").document(currentUserID).getDocument { (snapshot, err) in
            if let err = err {
                print(err)
                return
            }
            guard let snapDoc = snapshot else {return}
            guard let documents = snapDoc.data() else {return}
            self.currentUser = User(dict: documents)
            self.fetchUsers()
        }
    }
    
    
    fileprivate func setUpCards(user: CardViewModel) {
        let swipeableUser = SwipeablePhotoCardView()
        swipeableUser.delegate = self
        swipeableUser.cardObject = user
        cardContainer.addSubview(swipeableUser)
        cardContainer.sendSubviewToBack(swipeableUser)
        swipeableUser.fillToSuperView()
    }
    
    
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
        fetchCurrentUser()
    }
}

extension HomeController: LogOutInteraction {
    func logOutUser() {
        let settingsController = SettingsController()
        let navigationController = UINavigationController(rootViewController: settingsController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
}
