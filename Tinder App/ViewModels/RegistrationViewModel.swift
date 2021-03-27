//
//  File.swift
//  Tinder App
//
//  Created by Kingsley Charles on 27/03/2021.
//

import Foundation
import RxSwift
import RxCocoa
import Firebase

class RegistrationViewModel {
    var profileImage: UIImage? = nil
    typealias completion = ((Error)?) -> ()
    let isCorrectlyFilled = PublishSubject<Bool>()
    let imageContainer = PublishSubject<UIImage>()
    var imageObserver: Observable<UIImage> {
        return imageContainer.asObservable()
    }
    var correctEntry: Observable<Bool> {
        return isCorrectlyFilled.asObservable()
    }
    let hasRegistered = PublishSubject<Bool>()
    var registrationObserver: Observable<Bool> {
        return hasRegistered.asObservable()
    }
    
    var email: UserDetailsField?  {
        didSet{
            handleKeyboardInput()
        }
    }
    
    var password: UserDetailsField? {
        didSet{
            handleKeyboardInput()
        }
    }
    
    var username: UserDetailsField? {
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
        let isEmpty = (email?.text?.isEmpty ?? true || password?.text?.isEmpty ?? true || username?.text?.isEmpty ?? true || profileImage == nil)
        let isCompleted = !isEmpty
        
        _ = isCompleted ? isCorrectlyFilled.onNext(true) : isCorrectlyFilled.onNext(false)
    }
    
    func registerUser(completion: @escaping ((Error)?) -> ()) {
        guard let email = email?.text , let password = password?.text else {return}
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                completion(error)
                self.hasRegistered.onNext(false)
                return
            }
            self.storeUserProfile(completion: completion)
            completion(nil)
        }
        
    }
    
    fileprivate func storeUserProfile(completion: @escaping completion) {
        let filename = UUID().uuidString
        guard let uploadData = self.profileImage?.jpegData(compressionQuality: 0.25) else {return}
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let riversRef = storageRef.child("images/\(filename)")
        riversRef.putData(uploadData, metadata: nil) { (metadata, err) in
            if let err = err {
                completion(err)
                self.hasRegistered.onNext(false)
                return
            }
            storageRef.downloadURL { (url, err) in
                guard let url = url?.absoluteString else {return}
                print(url)
            }
            self.hasRegistered.onNext(true)
        }
       
        completion(nil)
    }
}

