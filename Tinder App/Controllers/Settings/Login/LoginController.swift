//
//  LoginViewController.swift
//  Tinder App
//
//  Created by Kingsley Charles on 24/04/2021.
//

import UIKit
import Foundation
import JGProgressHUD
import RxSwift
import RxCocoa

protocol HomeControllerUserRequest {
    func newUserRefetching()
}
class LoginController: UIViewController {
    let loginModel = LoginViewModel()
    var delegate: HomeControllerUserRequest?
    let loginStackView : UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .vertical
        return stackView
    }()
    
    let hud: JGProgressHUD = {
        let hud = JGProgressHUD(style: .dark)
        hud.textLabel.text = "Logging In"
        hud.shadow = JGProgressHUDShadow(color: .black, offset: .zero, radius: 5.0, opacity: 0.1)
        return hud
    }()
    
    var gradient : CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [#colorLiteral(red: 1, green: 0.4529054165, blue: 0.4463197589, alpha: 1).cgColor,#colorLiteral(red: 0.92856282, green: 0.1666355133, blue: 0.5210859776, alpha: 1).cgColor]
        gradient.locations = [0 , 1]
        return gradient
    }()
    
    lazy var emailTextField: UserDetailsField = {
        let txt = UserDetailsField()
        txt.placeholder = "Enter Email"
        txt.backgroundColor = .white
        txt.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
        return txt
    }()
    
    lazy var passwordTextField: UserDetailsField = {
        let txt = UserDetailsField()
        txt.placeholder = "Enter Password"
        txt.isSecureTextEntry = true
        txt.backgroundColor = .white
        txt.addTarget(self, action: #selector(handleTextChanged), for: .editingChanged)
        return txt
    }()
    
    lazy var loginButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 25
        btn.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        btn.isEnabled = true
        btn.setTitle("Log In", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .black)
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.addTarget(self, action: #selector(signInUser), for: .touchUpInside)
        return btn
    }()
    
    lazy var registerNavigation: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(userRegisterHandler), for: .touchUpInside)
        btn.setTitle("Back To Register", for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: true)
        setGradientBackground()
        addSubViews()
        setUpView()
        keyboardDismissGesture()
        handleKeyBoardObserver()
    }
    
    @objc fileprivate func userRegisterHandler() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func signInUser() {
        self.view.endEditing(true)
        hud.show(in: self.view)
        loginModel.signInUsers { err in
            if let err = err {
                self.hud.textLabel.text = "Error Logging In"
                self.hud.detailTextLabel.text = err.localizedDescription
                self.hud.dismiss(afterDelay: 2, animated: true)
                return
            }
            
            self.dismiss(animated: true) {
                self.delegate?.newUserRefetching()
            }
            
        }
        
    }
    
    fileprivate func handleKeyBoardObserver() {
        
        _ = loginModel.validEntry.subscribe(onNext: { [weak self] authorised in
            if authorised == true {
                self?.loginButton.backgroundColor = #colorLiteral(red: 0.8081405759, green: 0.1042295471, blue: 0.3269608021, alpha: 1)
                self?.loginButton.isEnabled = true
            } else {
                self?.loginButton.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
                self?.loginButton.isEnabled = true
            }
        })
        
        _ = loginModel.loginObserver.subscribe(onNext: { [weak self] hasSignedIn in
            if hasSignedIn == true {
                self?.hud.dismiss()
            }
            else {
                self?.hud.show(in: self!.view)
            }
        })
    }
    
    @objc fileprivate func handleTextChanged(textfield: UserDetailsField) {
        if textfield == passwordTextField {
            loginModel.password = textfield
        }
        
        if textfield == emailTextField {
            loginModel.email = textfield
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
    
    fileprivate func addSubViews() {
        self.loginStackView.addArrangedSubview(emailTextField)
        self.loginStackView.addArrangedSubview(passwordTextField)
        self.loginStackView.addArrangedSubview(loginButton)
        view.addSubview(self.loginStackView)
        view.addSubview(self.registerNavigation)
    }
    
    fileprivate func setUpView() {
        loginStackView.anchor(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        loginStackView.anchor(top: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, padding: .init(top: 0, left: 50, bottom: 0, right: 50))
        loginStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        registerNavigation.anchor(top: nil, leading: nil, trailing: nil, bottom: view.bottomAnchor,size: CGSize(width: 150, height: 90))
        registerNavigation.centerXAnchor.constraint(equalTo: view.centerXAnchor) .isActive = true
    }
}
