//
//  User.swift
//  Tinder App
//
//  Created by Kingsley Charles on 18/03/2021.
//

import Foundation
import UIKit

class User: ProducesCardViewModel {
    var name: String
    var age: Int?
    var imageProfile1Url: String?
    var imageProfile2Url: String?
    var imageProfile3Url: String?
    var profession: String?
    var uid: String
    var maxAge: Int
    var minAge: Int
    
    init(dict: [String:Any]) {
        self.name = dict["fullname"] as! String
        self.age = dict["age"] as? Int ?? 0
        self.imageProfile1Url = dict["imageUrl"] as? String ?? ""
        self.imageProfile2Url = dict["imageProfile2Url"] as? String ?? ""
        self.imageProfile3Url = dict["imageProfile3Url"] as? String ?? ""
        self.profession = dict["profession"] as? String ?? "Not Available"
        self.uid = dict["uid"] as! String
        self.maxAge = dict["maxAge"] as? Int ?? 20
        self.minAge = dict["minAge"] as? Int ?? 18
    }
    
    
    func convertToCardModel() -> CardViewModel {
        let attributedString = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 35)])
        attributedString.append(NSAttributedString(string: "  "))
        attributedString.append(NSAttributedString(string: "\(age!.toString())", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        attributedString.append(NSAttributedString(string: "\n \(profession ?? "" )" , attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        let userImages = setUpImages()
        return CardViewModel(imageAsset: userImages, attributedString: attributedString, textAlignment: .left)
    }
    
    func setUpImages() -> [String] {
        var nonNilImages = [String]()
        if let images = imageProfile1Url, !images.isEmpty{
            nonNilImages.append(images)
        }
        if let images = imageProfile2Url, !images.isEmpty {
            nonNilImages.append(images)
        }
        if let images = imageProfile3Url, !images.isEmpty {
            nonNilImages.append(images)
        }
        return nonNilImages
    }
}
