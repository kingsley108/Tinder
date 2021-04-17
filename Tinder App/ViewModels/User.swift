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
    var age: String?
    var imageProfile1Url: String?
    var imageProfile2Url: String?
    var imageProfile3Url: String?
    var profession: String?
    var uid: String
    
    init(dict: [String:Any]) {
        self.name = dict["fullname"] as! String
        self.age = dict["age"] as? String ?? "N/A"
        self.imageProfile1Url = dict["imageUrl"] as? String ?? ""
        self.imageProfile2Url = dict["imageProfile2Url"] as? String ?? ""
        self.imageProfile3Url = dict["imageProfile3Url"] as? String ?? ""
        self.profession = dict["profession"] as? String ?? "Not Available"
        self.uid = dict["uid"] as! String
    }
    
    
    func convertToCardModel() -> CardViewModel {
        let attributedString = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 35)])
        attributedString.append(NSAttributedString(string: "  "))
        attributedString.append(NSAttributedString(string: "\(age ?? "N/A")", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        attributedString.append(NSAttributedString(string: "\n \(profession ?? "" )" , attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        return CardViewModel(imageAsset: [imageProfile1Url!], attributedString: attributedString, textAlignment: .left)
    }
}
