//
//  User.swift
//  Tinder App
//
//  Created by Kingsley Charles on 18/03/2021.
//

import Foundation
import UIKit

class User: ProducesCardViewModel {
    let name: String
    let age: String?
    let imageProfilesUrl: String
    let profession: String?
    let uid: String
    
    init(name: String, age: String?, imageProfiles: String, profession: String?, uid: String) {
        self.name = name
        self.age = age ?? "N/A"
        self.imageProfilesUrl = imageProfiles
        self.profession = profession ?? "Not Available"
        self.uid = uid
    }
    
    
    func convertToCardModel() -> CardViewModel {
        let attributedString = NSMutableAttributedString(string: name, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 35)])
        attributedString.append(NSAttributedString(string: "  "))
        attributedString.append(NSAttributedString(string: "\(age ?? "N/A")", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        attributedString.append(NSAttributedString(string: "\n \(profession ?? "" )" , attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        return CardViewModel(imageAsset: [imageProfilesUrl], attributedString: attributedString, textAlignment: .left)
    }
}
