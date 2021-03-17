//
//  SwipeablePhoto.swift
//  Tinder App
//
//  Created by Kingsley Charles on 17/03/2021.
//

import UIKit

class SwipeablePhoto: UIView {
    lazy var photoView: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 10
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(photoView)
        photoView.fillToSuperView()
        addPanGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Pan gesture
    func addPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture))
        addGestureRecognizer(panGesture)
    }
    
    @objc func handleGesture(gesture: UIPanGestureRecognizer) {
        
        let translation = gesture.translation(in: nil)
        
        switch gesture.state {
        case .changed:
            self.transform = CGAffineTransform(translationX: translation.x, y: translation.y)
        case .ended:
            animateEnded()
        default:
            break
        }
        
    }
    
    func animateEnded() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.1, options: .curveEaseOut) {
            self.transform = .identity
        }
    }
}
