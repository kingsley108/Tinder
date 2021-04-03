//
//  SettingsController.swift
//  Tinder App
//
//  Created by Kingsley Charles on 31/03/2021.
//

import UIKit
import Firebase

class SettingsController: UITableViewController, SettingsViewProtocol {
    
    var sender: UIButton?
    var user: User?
    let headerView = SettingsHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .systemGray5
        tableView.keyboardDismissMode = .interactive
        setUpNavigation()
        fetchUserDetails()
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
                    guard let name = dict["fullname"] as? String else {return}
                    guard let imageUrl = dict["imageUrl"] as? String else {return}
                    self.user = User(name: name, age: nil, imageProfiles: imageUrl, profession: nil, uid: uid)
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
        
    }
    
    fileprivate func setUsersProfileImages() {
        guard let user = self.user else {return}
        guard let url = URL(string: user.imageProfilesUrl) else {return}
        if headerView.mainDisplayImage1.imageView?.image == nil {
            headerView.mainDisplayImage1.sd_setImage(with: url, for: .normal, placeholderImage: nil,options: .continueInBackground)
        }
    }
    
    
    @objc fileprivate func logoutSettings() {
        let registrationController = RegistrationController()
        let navigationController = UINavigationController(rootViewController: registrationController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 0 : 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  SettingsViewCell(style: .default, reuseIdentifier: nil)
        let inputCell = cell.settingsInputField
        cell.selectionStyle = .none
        switch indexPath.section{
        case 1:
            inputCell.placeholder = "Enter Name"
            inputCell.text = user?.name
        case 2:
            inputCell.placeholder = "Enter Profession"
        case 3:
            inputCell.placeholder = "Enter Age"
        case 4:
            inputCell.placeholder = "Enter Bio"
        default:
            break
        }
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            headerView.delegate = self
            return headerView
        }
        
        let headerCell = SettingsGroupHeaderLabel()
        switch section {
        case 1:
            headerCell.text = "Name"
        case 2:
            headerCell.text = "Profession"
        case 3:
            headerCell.text = "Age"
        case 4:
            headerCell.text = "Bio"
        default:
            headerCell.text = ""
        }
        return headerCell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 300 : 40
    }
}
