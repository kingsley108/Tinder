//
//  UserDetailsController.swift
//  Tinder App
//
//  Created by Kingsley Charles on 01/05/2021.
//

import Foundation
import UIKit

class UserDetailsController: UIViewController, UIScrollViewDelegate {
   
    lazy var detailsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delegate = self
        return scrollView
    }()
    
    lazy var userImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.image = #imageLiteral(resourceName: "kelly3")
        img.clipsToBounds = true
        return img
    }()
    
    lazy var userInformationLabel : UILabel = {
        let lbl = UILabel()
        lbl.text = "Username \n Doctor \n Some Bio Information"
        lbl.numberOfLines = 0
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        return lbl
    }()
        
        
    override func viewDidLoad() {
        self.addSubViews()
        self.updateConstraints()
        self.setUpGesture()
    }
    
    fileprivate func addSubViews() {
        view.addSubview(detailsScrollView)
        detailsScrollView.addSubview(userImageView)
        detailsScrollView.addSubview(userInformationLabel)
    }
    
    fileprivate func setUpGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc fileprivate func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func updateConstraints() {
        detailsScrollView.fillToSuperView()
        userImageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width)
        userInformationLabel.anchor(top: userImageView.bottomAnchor, leading: detailsScrollView.leadingAnchor, trailing: detailsScrollView.trailingAnchor, bottom: detailsScrollView.bottomAnchor, padding: UIEdgeInsets.init(top: 16, left: 0, bottom: 0, right: 16))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let changeIny = -scrollView.contentOffset.y
        let yOffset = min(0, (-changeIny))
        print(yOffset)
        let width = view.frame.width - yOffset
        userImageView.frame = CGRect(x: yOffset, y: yOffset, width: width, height: width)
    
    }
}

