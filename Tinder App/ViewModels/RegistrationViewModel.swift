//
//  File.swift
//  Tinder App
//
//  Created by Kingsley Charles on 27/03/2021.
//

import Foundation
class RegistrationViewModel {
    
    var emailTextField: UserDetailsField?  {
        didSet{
            handleKeyboardInput()
        }
    }
    
    var passwordField: UserDetailsField? {
        didSet{
            handleKeyboardInput()
        }
    }
    
    var usernameField: UserDetailsField? {
        didSet{
            handleKeyboardInput()
        }
    }
    
    var observer: ((Bool) -> ())?
    
    fileprivate func handleKeyboardInput() {
        if usernameField?.text?.isEmpty ?? true || passwordField?.text?.isEmpty ?? true || emailTextField?.text?.isEmpty ?? true {
            self.observer?(false)
        }
        else {
            self.observer?(true)
        }
    }
}
