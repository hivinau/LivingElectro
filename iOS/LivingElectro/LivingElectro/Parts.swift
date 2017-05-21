//
//  Parts.swift
//  LivingElectro
//
//  Created by iOS Developer on 17/05/2017.
//  Copyright © 2017 Hivinau GRAFFE. All rights reserved.
//

import UIKit

public protocol PartsDelegate: class {
    
    func parts(_ parts: Parts, didSelectRowAt indexPath: IndexPath)
}

@objc(Parts)
public class Parts: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate, RowSelecting {
    
    private var currentPosition = -1
    private var controllers = [UIViewController]()
    private var scrollView: UIScrollView?
    private let locker = NSLock()

    public var partsDelegate: PartsDelegate?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        let views = view.subviews.filter({
            view in
            
            return view is UIScrollView
        })
        
        dataSource = self
        delegate = self
        
        if views.count == 1 {
            
            scrollView = views[0] as? UIScrollView
            scrollView?.isScrollEnabled = true
            scrollView?.delegate = self
        }
    }
    
    public func selectRow(at indexPath: IndexPath) {
        
        locker.lock() ; defer { locker.unlock() }
        
        if indexPath.row < controllers.count {
            
            let direction = currentPosition - indexPath.row > 0 ? UIPageViewControllerNavigationDirection.reverse : UIPageViewControllerNavigationDirection.forward
            
            setViewControllers([controllers[indexPath.row]], direction: direction, animated: true, completion: nil)
        }
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let current = controllers.index(of: viewController) else {
            
            return nil
        }
        
        let previous = current - 1
        
        guard previous >= 0 else {
            
            //return controllers.last //uncomment for infinite loop
            return nil
        }
        
        guard controllers.count > previous else {
            
            return nil
        }
        
        return controllers[previous]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let current = controllers.index(of: viewController) else {
            
            return nil
        }
        
        let next = current + 1
        
        guard controllers.count != next else {
            
            //return controllers.first //uncomment for infinite loop
            return nil
        }
        
        guard controllers.count > next else {
            
            return nil
        }
        
        return controllers[next]
    }
    
    public func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if finished && completed {
            
            notify()
        }
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        notify()
    }
    
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if !decelerate {
            
            scrollViewDidEndDecelerating(scrollView)
        }
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        scrollViewDidEndDecelerating(scrollView)
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        notify()
    }
    
    public func addSongs(for title: String) {
        
        locker.lock() ; defer { locker.unlock() }
        
        let storyBoard = UIStoryboard(name: "Main", bundle:nil)
        
        if let controller = storyBoard.instantiateViewController(withIdentifier: "Songs") as? Songs {
            
            controller.title = title
            
            controllers.append(controller)
            setViewControllers([controllers[0]], direction: .forward, animated: true, completion: nil)
        }

    }
    
    private func notify() {
        
        if let controllers = viewControllers,
            let controller = controllers.last {
            
            if let index = self.controllers.index(of: controller) {
                
                currentPosition = index
                
                let indexPath = IndexPath(item: index, section: 0)
                partsDelegate?.parts(self, didSelectRowAt: indexPath)
            }
        }
    }


}
