//
//  UserDetailsController.swift
//  Tinder App
//
//  Created by Kingsley Charles on 01/05/2021.
//

import Foundation
import UIKit
import SDWebImage

class UserDetailsController: UIViewController, UIScrollViewDelegate {
    
    var cardModel: CardViewModel? {
        didSet {
            guard let url = URL(string: cardModel?.imageAsset.first ?? "") else {return}
            userImageView.sd_setImage(with: url)
            userInformationLabel.attributedText = cardModel?.attributedString
        }
    }
    
    lazy var buttonsStackView: UIStackView = {
        let stckView = UIStackView()
        stckView.axis = .horizontal
        stckView.distribution = .fillEqually
        return stckView
    }()
    
    lazy var exitButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "dismiss_circle"), for: .normal)
        return btn
    }()
    
    lazy var starButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "super_like_circle"), for: .normal)
        return btn
    }()
    
    lazy var loveButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "like_circle"), for: .normal)
        return btn
    }()
        
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var blurEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        return blurredEffectView
    }()
    
    lazy var detailsScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.delegate = self
        return scrollView
    }()
    
    lazy var dismissButton: UIButton = {
       let btn = UIButton()
        btn.imageView?.contentMode = .scaleAspectFill
        btn.imageView?.clipsToBounds = true
        btn.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        btn.setImage(#imageLiteral(resourceName: "dismiss_down_arrow"), for: .normal)
        return btn
    }()
    
    lazy var userImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
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
        view.backgroundColor = .white
    }
    
    fileprivate func addSubViews() {
        view.addSubview(detailsScrollView)
        view.addSubview(buttonsStackView)
        detailsScrollView.addSubview(userImageView)
        userImageView.addSubview(blurEffect)
        detailsScrollView.addSubview(userInformationLabel)
        detailsScrollView.addSubview(dismissButton)
        buttonsStackView.addArrangedSubview(exitButton)
        buttonsStackView.addArrangedSubview(starButton)
        buttonsStackView.addArrangedSubview(loveButton)
        
    }
    
    @objc fileprivate func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func updateConstraints() {
        detailsScrollView.fillToSuperView()
        userImageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.width)
        blurEffect.anchor(top:userImageView.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: detailsScrollView.safeAreaLayoutGuide.topAnchor)
        userInformationLabel.anchor(top: userImageView.bottomAnchor, leading: detailsScrollView.leadingAnchor, trailing: detailsScrollView.trailingAnchor, bottom: detailsScrollView.bottomAnchor, padding: UIEdgeInsets.init(top: 16, left: 16, bottom: 0, right: 0))
        dismissButton.anchor(top: nil, leading: nil, trailing:userImageView.trailingAnchor, bottom: userImageView.bottomAnchor,size: .init(width: 50, height: 50), padding: UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 20))
        buttonsStackView.anchor(top: nil, leading: nil, trailing: nil, bottom: view.bottomAnchor,size: .init(width: 300, height: 80),padding: .init(top: 0, left: 0, bottom: 40, right: 0))
        buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let changeIny = -scrollView.contentOffset.y
        let yOffset = min(0, (-changeIny))
        let width = view.frame.width - yOffset
        userImageView.frame = CGRect(x: yOffset, y: yOffset, width: width, height: width)
    }
}

