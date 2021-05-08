//
//  pageViewController.swift
//  Tinder App
//
//  Created by Kingsley Charles on 08/05/2021.
//

import Foundation
import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var nextImageTrackerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 12
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    var cardModel: CardViewModel? {
        didSet {
            cardModel?.imageAsset.forEach({ imageString in
                guard let urlString = URL(string: imageString) else {return}
                let photoController = PhotoController(url: urlString)
                controllers.append(photoController)
            })
            
            if let firstVC = controllers.first {
                setViewControllers([firstVC], direction: .forward, animated: true)
            }
        }
    }

    var controllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        setUpTabBar()
    }
    
    fileprivate func setUpTabBar() {
        view.addSubview(nextImageTrackerStackView)
        cardModel?.imageAsset.forEach({ images in
            let nextAssetIcon = UIView()
            nextAssetIcon.backgroundColor = UIColor(white: 0, alpha: 0.1)
            nextAssetIcon.layer.cornerRadius = 2
            nextImageTrackerStackView.addArrangedSubview(nextAssetIcon)
        })
        nextImageTrackerStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, size: .init(width: 0, height: 4), padding: .init(top: 4, left: 8, bottom: 0, right: 8))
        nextImageTrackerStackView.arrangedSubviews[0].backgroundColor = .white
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVc = viewControllers?.first else {return}
        guard let index = controllers.firstIndex(of: currentVc) else {return}
        nextImageTrackerStackView.arrangedSubviews.forEach({$0.backgroundColor = UIColor(white: 0, alpha: 0.1)})
        nextImageTrackerStackView.arrangedSubviews[index].backgroundColor = .white
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard var nextIndex = controllers.firstIndex(of: viewController) else {return nil}
        nextIndex += 1
        guard nextIndex < controllers.count else {
            return nil
        }
        return controllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard var previousIndex = controllers.firstIndex(of: viewController) else {return nil}
    
        previousIndex -= 1
        guard previousIndex >= 0 else {return nil}
        return controllers[previousIndex]
    }
    
}
