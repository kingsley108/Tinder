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
    let imageAsset1: [UIImage]
    
    init(brandName: String, imageAsset: [UIImage]) {
        self.brandName = brandName
        self.imageAsset1 = imageAsset
    }
    func convertToCardModel() -> CardViewModel {
        let attributedString = NSMutableAttributedString(string: "Slide Out Menu", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 35)])
        attributedString.append(NSAttributedString(string: " \n   Lets Build That App", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))

        return CardViewModel(imageAsset: imageAsset1, attributedString: attributedString, textAlignment: .center)
    }
}
