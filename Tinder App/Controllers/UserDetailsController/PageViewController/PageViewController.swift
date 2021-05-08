//
//  pageViewController.swift
//  Tinder App
//
//  Created by Kingsley Charles on 08/05/2021.
//

import Foundation
import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
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
