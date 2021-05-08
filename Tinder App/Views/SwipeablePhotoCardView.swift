//
//  SwipeablePhoto.swift
//  Tinder App
//
//  Created by Kingsley Charles on 17/03/2021.
//

import UIKit
import SDWebImage

protocol HomeUserDetailsTransition {
    func transitionToUserDetails(cardModel: CardViewModel)
}

class SwipeablePhotoCardView: UIView {
    var delegate: HomeUserDetailsTransition?
    let gradient = CAGradientLayer()
    var tapBar = UIStackView()
    var index = 0
    var imagesCount: Int?

    var cardObject: CardViewModel? {
        didSet {
            guard let user = self.cardObject else { return}
            
            self.imagesCount = user.imageAsset.count
            guard let url = URL(string: user.imageAsset.first ?? "" ) else {return}
            photoView.sd_setImage(with: url)
            informationDetailsLabel.attributedText = user.attributedString
            informationDetailsLabel.textAlignment = user.textAlignment
            for _ in 1...imagesCount! {
                let view = UIView()
                view.backgroundColor = UIColor(white: 0, alpha: 0.1)
                view.layer.cornerRadius = 2
                tapBar.addArrangedSubview(view)
            }
            tapBar.arrangedSubviews[index].backgroundColor = .white
            setUpObserver()
        }
    }
    
    var photoView: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 10
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    var informationDetailsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        return label
    }()
    
    var userDetailsPageButton: UIButton = {
        let btn = UIButton()
        btn.tintColor = .white
        btn.setImage(UIImage(systemName: "info.circle.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.imageView?.layer.transform = CATransform3DMakeScale(2, 2, 2)
        btn.addTarget(self, action: #selector(displayUserDetailsPage), for: .touchUpInside)
        return btn
    }()
    
    @objc fileprivate func displayUserDetailsPage() {
        guard let cardObject = self.cardObject else {return}
        delegate?.transitionToUserDetails(cardModel: cardObject)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        addGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setUpPhotoCardView() {
        informationDetailsLabel.anchor(top: nil, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 0))
        userDetailsPageButton.anchor(top: nil, leading: nil, trailing: trailingAnchor, bottom: bottomAnchor, size: .init(width: 44, height: 44), padding: .init(top: 0, left: 0, bottom: 20, right: 20))
    }
    
    fileprivate func setUpView() {
        addSubview(photoView)
        photoView.fillToSuperView()
        setUpTapBar()
        setGradientBackground()
        addSubview(informationDetailsLabel)
        addSubview(userDetailsPageButton)
        setUpPhotoCardView()
    }
    
    func setUpTapBar() {
      addSubview(tapBar)
        tapBar.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil,padding: .init(top: 8, left: 8, bottom: 0, right: 8))
        tapBar.heightAnchor.constraint(equalToConstant: 4).isActive = true
        tapBar.spacing = 4
        tapBar.distribution = .fillEqually
    }
    
    func setGradientBackground() {
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.locations = [0.9 , 1.1]
        layer.addSublayer(gradient)
    }
    
    override func layoutSubviews() {
        gradient.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    }
    
    func setUpObserver() {
        guard let user = self.cardObject else {return}
        user.imageObserver = { [weak self] image, index in
            let url = URL(string: user.imageAsset[user.imageIndex])
            self?.photoView.sd_setImage(with: url)
            self?.tapBar.arrangedSubviews.forEach({$0.backgroundColor = UIColor(white: 0, alpha: 0.1)})
            self?.tapBar.arrangedSubviews[user.imageIndex].backgroundColor = .white
        }
    }
    
    //Pan gesture
    func addGestures() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture))
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        addGestureRecognizer(tapGesture)
        addGestureRecognizer(panGesture)
    }
    
    @objc func handleTapGesture(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: nil)
        let didTapFoward = (Int(location.x) > 156) ? true : false
        didSkipFoward(for: didTapFoward)
    }
    
    func didSkipFoward(for didTapFoward: Bool) {
        if didTapFoward == true {
            skip(fowards: 1)
        }
        if didTapFoward == false {
            skip(backwards: -1)
        }
    }
    
    func skip(fowards forVal: Int) {
        cardObject?.skip(fowards: forVal)
    }
    
    func skip(backwards forVal: Int) {
        cardObject?.skip(backwards: forVal)
    }
    
    
    @objc func handleGesture(gesture: UIPanGestureRecognizer) {
        let imagesCompleted = photoView.image == nil
        let translation = gesture.translation(in: nil)
        let degrees = (translation.x / 20) * CGFloat.pi / 180
        
        switch gesture.state {
        case .changed:
            if imagesCompleted == true {removeGestureRecognizer(gesture)}
            self.transform = CGAffineTransform(rotationAngle: degrees).translatedBy(x: translation.x, y: translation.y)
            
        case .ended:
            animateEnded(animatedby: Int(translation.x), gesture: gesture)
            
        default:
            break
        }
    }
    
    func animateEnded(animatedby: Int, gesture: UIPanGestureRecognizer ) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut) {
            if animatedby > 120 || animatedby < -120 {
                self.center = CGPoint(x: 1000 * translationDirection, y: 0)
                self.removeFromSuperview()
            }
            else {
                self.transform = .identity
            }
            
        } completion: { (_) in
        }
    }
}
