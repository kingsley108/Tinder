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

class CardViewModel {
    let imageAsset: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
    init(imageAsset: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
        self.imageAsset = imageAsset
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }
    
    var imageIndex = 0 {
        didSet{
           let image = imageAsset[imageIndex]
            imageObserver?(image, imageIndex)
        }
    }
    
    func skip(fowards forVal: Int) {
        var index = imageIndex + forVal
        if index > imageAsset.count - 1 { index = 0}
        imageIndex = index
    }
    
    func skip(backwards forVal: Int) {
        var index = imageIndex + forVal
        if index < 0 { index = 0}
        imageIndex = index
    }
    
    var imageObserver:((String, Int) -> ())?
}
