//
//  ViewController.swift
//  EWSegmentView-Swift
//
//  Created by wansy on 15/8/27.
//  Copyright (c) 2015年 com.hengtiansoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var headView: EWSegmentHeadView!

    @IBOutlet weak var segmentView: EWSegmentView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1:UIViewController = UIViewController()
        vc1.view.backgroundColor = UIColor.yellowColor()
        vc1.title = "视图1"
       
        let vc2:UIViewController = UIViewController()
        vc2.view.backgroundColor = UIColor.redColor()
        vc2.title = "视图2"
        
        let vc3:UIViewController = UIViewController()
        vc3.view.backgroundColor = UIColor.greenColor()
        vc3.title = "视图3"
        
        let array = [vc1,vc2,vc3]
        
        segmentView.subViewControllers = array
        
        segmentView.headView = headView
        
    }


}

