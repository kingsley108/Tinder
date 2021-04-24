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
        self.hasRegistered.onNext(false)
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
    
            if let error = error {
                completion(error)
                self.hasRegistered.onNext(false)
                return
            }
            self.saveImageToFirebase(completion: completion)
        }
        
    }
    
    //Storing the image to fireBase storage.
    fileprivate func saveImageToFirebase(completion: @escaping completion) {
        let filename = UUID().uuidString
        guard let uploadData = self.profileImage?.jpegData(compressionQuality: 0.25) else {return}
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let storeImage = storageRef.child("images/\(filename)")
        storeImage.putData(uploadData, metadata: nil) { (metadata, err) in
            if let err = err {
                completion(err)
                self.hasRegistered.onNext(false)
                return
            }
            
            storeImage.downloadURL { (url, err) in
                guard let url = url?.absoluteString else {return}
                self.saveUserDocuments(imageUrl: url, completion: completion)
            }
        }
    }
    
    fileprivate func saveUserDocuments(imageUrl: String, completion: @escaping completion) {
        guard let userId = Auth.auth().currentUser?.uid else {return}
        let db = Firestore.firestore()
        let document: [String: Any] = ["fullname": username?.text ?? "", "imageUrl": imageUrl, "uid": userId]
        db.collection("users").document(userId).setData(document) { err in
            self.hasRegistered.onNext(true)
            if let err = err {
                completion(err)
                self.hasRegistered.onNext(false)
                return
            }
            completion(nil)
        }
    }
}

