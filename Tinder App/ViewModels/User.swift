//
//  User.swift
//  Tinder App
//
//  Created by Kingsley Charles on 18/03/2021.
//

import Foundation
import UIKit

class User: ProducesCardViewModel {
    let name: String?
    let age: Int?
    let imageProfiles: [UIImage]
    let profession: String
    
    init(name: String, age: Int, imageProfiles: [UIImage], profession: String) {
        self.name = name
        self.age = age
        self.imageProfiles = imageProfiles
        self.profession = profession
    }
    
    
    func convertToCardModel() -> CardViewModel {
        let attributedString = NSMutableAttributedString(string: name!, attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 35)])
        attributedString.append(NSAttributedString(string: "  "))
        attributedString.append(NSAttributedString(string: "\(age ?? 0)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        attributedString.append(NSAttributedString(string: "\n \(profession )" , attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
        return CardViewModel(imageAsset: imageProfiles, attributedString: attributedString, textAlignment: .left)
    }
}
