//
//  File.swift
//  Tinder App
//
//  Created by Kingsley Charles on 27/03/2021.
//

import Foundation
import RxSwift
import RxCocoa

class RegistrationViewModel {
    var profileImage: UIImage? = nil
    let isCorrectlyFilled = PublishSubject<Bool>()
    let imageContainer = PublishSubject<UIImage>()
    var imageObserver: Observable<UIImage> {
        return imageContainer.asObservable()
    }
    var correctEntry: Observable<Bool> {
        return isCorrectlyFilled.asObservable()
    }
    
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
    func imageSubsciber() {
        _ = imageObserver.subscribe { [weak self] image in
            self?.profileImage = image.element
            self?.handleKeyboardInput()
        }
    }
    
    
     func handleKeyboardInput() {
        let isEmpty = (emailTextField?.text?.isEmpty ?? true || passwordField?.text?.isEmpty ?? true || usernameField?.text?.isEmpty ?? true || profileImage == nil)
        let isCompleted = !isEmpty
        
            _ = isCompleted ? isCorrectlyFilled.onNext(true) : isCorrectlyFilled.onNext(false)
    }
}

