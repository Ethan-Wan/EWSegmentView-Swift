//
//  EWSegmentView.swift
//  EWSegmentView-Swift
//
//  Created by wansy on 15/8/28.
//  Copyright (c) 2015年 com.hengtiansoft. All rights reserved.
//

import UIKit

class EWSegmentView: UIView,UIPageViewControllerDataSource,UIPageViewControllerDelegate {

    var subViewControllers = [UIViewController]()
    {
        didSet
        {
            if count(self.subViewControllers) > 0
            {
                self.pageViewController.setViewControllers([self.subViewControllers[0]], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
            }
        }
    }
    
    var headView:EWSegmentHeadView!
    {

        didSet
        {
//            self.headView.delegate = self
            
            self.headView.setHeadTitles(getTitles())
            
            self.headView.didClick =
            {
                let subVCs = self.subViewControllers as NSArray
                let direction:UIPageViewControllerNavigationDirection = self.headView.selectedButtonIndex > subVCs.indexOfObject(self.pageViewController.viewControllers[self.pageViewController.viewControllers.count - 1]) ?UIPageViewControllerNavigationDirection.Forward : UIPageViewControllerNavigationDirection.Reverse
                
                self.pageViewController.setViewControllers([self.selectedController()], direction: direction, animated: true, completion: nil)
            }
        }
    }
    
    private var pageViewController:UIPageViewController!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup()
    {
        self.pageViewController = UIPageViewController(transitionStyle: UIPageViewControllerTransitionStyle.Scroll, navigationOrientation: UIPageViewControllerNavigationOrientation.Horizontal, options: nil)
        self.pageViewController.view.frame = self.bounds
        self.pageViewController.dataSource = self
        self.pageViewController.delegate = self
        self.pageViewController.view.autoresizingMask = (UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight)
        self.addSubview(pageViewController.view)
    }
    
    private func getTitles() -> [String]
    {
        var titles = [String]()
        for vc in self.subViewControllers
        {
            let title = vc.title ?? "视图"
            titles.append(title)
        }
        return titles
    }
    
    private func selectedController() -> UIViewController
    {
        return self.subViewControllers[self.headView!.selectedButtonIndex]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let subVCs = self.subViewControllers as NSArray
        var index:Int = subVCs.indexOfObject(viewController)
        
        if index == 0
        {
            return nil
        }
        return self.subViewControllers[--index]
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let subVCs = self.subViewControllers as NSArray
        var index:Int = subVCs.indexOfObject(viewController)
        
        if index+1 >= self.subViewControllers.count
        {
            return nil
        }
        return self.subViewControllers[++index]
    }
    
    func pageViewController(pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [AnyObject], transitionCompleted completed: Bool) {
        if !completed
        {
            return
        }
        
        let subVCs = self.subViewControllers as NSArray
        self.headView.selectedButtonIndex = subVCs.indexOfObject(pageViewController.viewControllers[count(pageViewController.viewControllers) - 1])

    }
    
    
}
