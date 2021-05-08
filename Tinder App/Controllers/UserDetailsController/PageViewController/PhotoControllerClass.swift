//
//  PhotoControllerClass.swift
//  Tinder App
//
//  Created by Kingsley Charles on 08/05/2021.
//

import Foundation
import UIKit


class PhotoController: UIViewController {
    let url: URL
    
    lazy var userImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        addSubView()
    }
    
    fileprivate func addSubView() {
        view.addSubview(userImageView)
        userImageView.sd_setImage(with: url)
        userImageView.fillToSuperView()
    }
    
}
