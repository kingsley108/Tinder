//
//  registrationController.swift
//  Tinder App
//
//  Created by Kingsley Charles on 26/03/2021.
//

import UIKit
import Foundation

class RegistrationController: UIViewController {
    let registrationModel = RegistrationViewModel()
    var gradient : CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [#colorLiteral(red: 1, green: 0.4529054165, blue: 0.4463197589, alpha: 1).cgColor,#colorLiteral(red: 0.92856282, green: 0.1666355133, blue: 0.5210859776, alpha: 1).cgColor]
        gradient.locations = [0 , 1]
        return gradient
    }()
    
    lazy var selectPhotoButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 16
        btn.backgroundColor = .white
        btn.setTitle("Select Photo", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .black)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.textAlignment = .center
        btn.heightAnchor.constraint(equalToConstant: 300).isActive = true
        return btn
    }()
    
    lazy var emailTextField: userDetailsField = {
        let txt = userDetailsField()
        txt.placeholder = "Enter Email"
        txt.backgroundColor = .white
        txt.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
        return txt
    }()
    
    lazy var usernameTextField: userDetailsField = {
        let txt = userDetailsField()
        txt.placeholder = "Enter Username"
        txt.backgroundColor = .white
        txt.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
        return txt
    }()
    
    lazy var passwordTextField: userDetailsField = {
        let txt = userDetailsField()
        txt.placeholder = "Enter Password"
        txt.isSecureTextEntry = true
        txt.backgroundColor = .white
        txt.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
        return txt
    }()
    
    lazy var registerButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 25
        btn.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        btn.isEnabled = true
        btn.setTitle("Register", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .black)
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: true)
        setGradientBackground()
        setUpView()
        keyboardDismissGesture()
        handleKeyBoardObserver()
    }
    
    fileprivate func handleKeyBoardObserver() {
        registrationModel.observer = { [weak self] isCompleted in
            if isCompleted == true {
                self?.registerButton.backgroundColor = #colorLiteral(red: 0.8081405759, green: 0.1042295471, blue: 0.3269608021, alpha: 1)
                self?.registerButton.isEnabled = true
            } else {
                self?.registerButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                self?.registerButton.isEnabled = true
            }
        }
    }
    
    @objc fileprivate func handleTextChanged(textfield: userDetailsField) {
        print(textfield)
        if textfield == passwordTextField {
            registrationModel.passwordField = textfield
        }
        if textfield == usernameTextField {
            registrationModel.usernameField = textfield
        }
        if textfield == emailTextField {
            registrationModel.emailTextField = textfield
        }
    }
    
    fileprivate func keyboardDismissGesture() {
        let swipeGesture = UISwipeGestureRecognizer (target: self, action: #selector(hideKeyboard))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    override func viewWillLayoutSubviews() {
        gradient.frame = view.bounds
    }
    
    func setGradientBackground() {
        view.layer.addSublayer(gradient)
    }
    
    fileprivate func setUpView() {
        let stackView = UIStackView(arrangedSubviews: [selectPhotoButton,emailTextField,usernameTextField,
                                                       passwordTextField, registerButton])
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.anchor(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
