//
//  CradViewModel.swift
//  Tinder App
//
//  Created by Kingsley Charles on 18/03/2021.
//

import Foundation
import UIKit
protocol ProducesCardViewModel {
    func convertToCardModel() -> CardViewModel
}

struct CardViewModel {
    let imageAsset: UIImage?
    let attributedString: NSAttributedString?
    let textAlignment: NSTextAlignment?
}
