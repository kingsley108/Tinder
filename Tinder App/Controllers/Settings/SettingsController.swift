//
//  SettingsController.swift
//  Tinder App
//
//  Created by Kingsley Charles on 31/03/2021.
//

import UIKit
import Firebase
import JGProgressHUD

protocol SaveSettingsNotifier {
    func didSaveRequests()
}

class SettingsController: UITableViewController, SettingsViewProtocol {
    
    var sender: UIButton?
    var senderReference = [UIButton]()
    var user: User?
    let headerView = SettingsHeaderView()
    var delegate: SaveSettingsNotifier?
    
    let hud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .dark)
        hud.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 5.0, opacity: 0.1)
        return hud
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .systemGray5
        tableView.keyboardDismissMode = .interactive
        setUpNavigation()
        fetchUserDetails()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setUsersProfileImages()
    }
    
    fileprivate func setUpNavigation () {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        self.tableView.separatorStyle = .none
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Settings"
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissView))
        let logoutButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutSettings))
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveSettings))
        navigationItem.leftBarButtonItem = cancel
        navigationItem.rightBarButtonItems = [saveButton, logoutButton]
        
    }
    
    fileprivate func fetchUserDetails() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore()
        let query = db.collection("users").document(uid)
        
        query.getDocument { (snapshot, err) in
            if let err = err {
                print(err)
                return
            }
            
            guard let snap = snapshot else {return }
            if let dict = snap.data() {
                self.user = User(dict: dict)
                self.setUsersProfileImages()
                self.tableView.reloadData()
            }
        }
    }
    
    func didChangeSettingsProfile(for sender: UIButton) {
        self.sender = sender
        self.getPhotoAsset()
    }
    
    @objc fileprivate func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    
    @objc fileprivate func saveSettings() {
        self.saveImages()
    }
    
    fileprivate func saveImages() {
        guard senderReference.count > 0 else {
            self.saveToDatabase()
            return
        }
        
        let uniqueSenders = Array(Set(senderReference))
        for senders in uniqueSenders {
            let tag = senders.tag
            guard let image = senders.image(for: .normal) else {return}
            senders.saveFirebaseStorage(for: image) { (urlString) in
                switch tag {
                case 1:
                    self.user?.imageProfile1Url = urlString
                case 2:
                    self.user?.imageProfile2Url = urlString
                case 3:
                    self.user?.imageProfile3Url = urlString
                default:
                    break
                }
                self.saveToDatabase()
            }
        }
    }
    
    fileprivate func saveToDatabase() {
        guard let userId = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore()
        let document: [String: Any] = ["fullname": user?.name ?? "", "imageUrl": user?.imageProfile1Url ?? "", "profession": user?.profession ?? "", "age" : user?.age ?? 0, "imageProfile2Url" : user?.imageProfile2Url, "imageProfile3Url": user?.imageProfile3Url, "uid": userId, "minAge": user?.minAge, "maxAge": user?.maxAge]
        
        db.collection("users").document(userId).setData(document) { (err) in
            self.hud.textLabel.text = "Saving Settings"
            if let err = err {
                self.hud.textLabel.text = "Error Registering"
                self.hud.detailTextLabel.text = err.localizedDescription
            }
            self.hud.show(in: self.view)
            self.hud.dismiss(afterDelay: 4, animated: true) {
                self.dismiss(animated: true) {
                    self.delegate?.didSaveRequests()
                }
            }
        }
    }
    
    fileprivate func setUsersProfileImages() {
        guard let user = self.user else {return}
        if headerView.mainDisplayImage1.imageView?.image == nil {
            guard let url = URL(string: user.imageProfile1Url ?? "") else {return}
            headerView.mainDisplayImage1.sd_setImage(with: url, for: .normal, placeholderImage: nil,options: .continueInBackground)
        }
        
        
        if user.imageProfile2Url != nil && headerView.alternateDisplayImage1.imageView?.image == nil {
            guard let url = URL(string: user.imageProfile2Url ?? "") else {return}
            headerView.alternateDisplayImage1.sd_setImage(with: url, for: .normal, placeholderImage: nil,options: .continueInBackground)
        }
        
        if user.imageProfile3Url != nil && headerView.alternateDisplayImage2.imageView?.image == nil {
            guard let url = URL(string: user.imageProfile3Url ?? "") else {return}
            headerView.alternateDisplayImage2.sd_setImage(with: url, for: .normal, placeholderImage: nil,options: .continueInBackground)
        }
        
    }
    
    
    @objc fileprivate func logoutSettings() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let registrationController = RegistrationController()
            let navigationController = UINavigationController(rootViewController: registrationController)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    @objc func userChangeRequest(sender: UITextField) {
        let textfieldId = sender.placeholder
        switch textfieldId {
        case "Enter Name":
            user?.name = sender.text ?? ""
        case "Enter Profession":
            user?.profession = sender.text ?? ""
            
        case "Enter Age":
            user?.age = Int(sender.text ?? "0")
            
        //        case "Enter Bio":
        //        user?.bio = sender.text ?? ""
        
        default:
            break
        }
    }
    
    @objc func sliderChanged (sender: UISlider) {
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 5)) as? AgeRangeCell
        let ageRange = Int(sender.value)
        switch sender.tag {
        case 1 :
            let roundedMax = String(format: "%i",Int(sender.value))
            cell?.maxAgeRange.text = "Max: \(roundedMax)"
            self.user?.maxAge = ageRange
            
        case 2:
            let roundedMin = String(format: "%i",Int(sender.value))
            cell?.minAgeRange.text = "Min: \(roundedMin)"
            self.user?.minAge = ageRange
        default:
            break
            
        }
        
    }
    
}
