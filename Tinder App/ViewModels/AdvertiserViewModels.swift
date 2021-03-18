//
//  AdvertiserViewModels.swift
//  Tinder App
//
//  Created by Kingsley Charles on 18/03/2021.
//

import Foundation
import UIKit

struct AdvertiserViewModels: ProducesCardViewModel{
    let brandName: String?
    let photoName: UIImage?
    
    func convertToCardModel() -> CardViewModel {
        let attributedString = NSMutableAttributedString(string: "Slide Out Menu", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 35)])
        attributedString.append(NSAttributedString(string: " \n   Lets Build That App", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))

        return CardViewModel(imageAsset: photoName, attributedString: attributedString, textAlignment: .center)
    }
}
