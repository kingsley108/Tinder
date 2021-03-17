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
        let degrees = (translation.x / 20) * CGFloat.pi / 180
        
        switch gesture.state {
        case .changed:
            self.transform = CGAffineTransform(rotationAngle: degrees).translatedBy(x: translation.x, y: translation.y)
            print(translation.x)
            
        case .ended:
            animateEnded(animatedby: Int(translation.x), gesture: gesture)
        default:
            break
        }
        
    }
    
    func animateEnded(animatedby: Int, gesture: UIPanGestureRecognizer ) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut) {
            if animatedby > 100 || animatedby < -100 {
                self.center = CGPoint(x: 1000 * translationDirection, y: 0)
            }
            else {
                self.transform = .identity
            }
            
        } completion: { (_) in
            self.frame = CGRect(x: 0,
                                y: 0,
                                width: self.superview!.frame.width,
                                height: self.superview!.frame.height)
            self.transform = .identity
            
        }
        
        
        
    }
}
