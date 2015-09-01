//
//  EWSegmentHeadView.swift
//  EWSegmentView-Swift
//
//  Created by wansy on 15/8/28.
//  Copyright (c) 2015年 com.hengtiansoft. All rights reserved.
//

import UIKit


typealias didHeadClick =  () -> ()
//protocol EWSegmentHeadViewDelegate{
//   func segmentHeadViewDidClick(headView:EWSegmentHeadView ,button:UIButton)
//}

class EWSegmentHeadView: UIView {
    
    var selectedTitleColor:UIColor?
    var normalTitleColor:UIColor?
    var bottomColor:UIColor?
    var hiddenBottom:Bool = true
//    var delegate: EWSegmentHeadViewDelegate?
    
    var didClick = didHeadClick?()
    
    var selectedButtonIndex:Int!
    {
        get
        {
            let subButtons = self.buttonView.subviews as NSArray
            return subButtons.indexOfObject(self.selectedHeadButton!)
        }
        set
        {
            let headButton:UIButton = self.buttonView.subviews[newValue] as! UIButton
            turnSelectButton(headButton)
        }
    }
    
    private var selectedHeadButton:UIButton?
    private var buttonView:UIView!
    private var slideLabel:UILabel!
    private var bottomView:UIView!
    
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
        self.buttonView = UIButton()
        self.addSubview(self.buttonView)
        
        self.bottomView = UIView()
        self.addSubview(self.bottomView)
        
        self.slideLabel = UILabel()
        self.addSubview(self.slideLabel)
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        let viewH:CGFloat = self.frame.size.height
        let viewW:CGFloat = self.frame.size.width
        print(self.buttonView.subviews.count)
        let headButtonW:CGFloat = viewW/CGFloat(count(self.buttonView.subviews))
        
        //按钮view布局
        self.buttonView.frame = CGRectMake(0, 0, viewW, viewH*0.9)
        
        let buttonViews = self.buttonView.subviews as NSArray
        
        //按钮布局
        buttonViews.enumerateObjectsUsingBlock { (object: AnyObject!, idx: Int, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            let headButton = object as! UIButton
            let headButtonX:CGFloat =  CGFloat(idx) * headButtonW
            headButton.frame = CGRectMake(headButtonX, 0, headButtonW , self.buttonView.bounds.size.height)
        }
        
        //底部view布局
        self.bottomView.frame = CGRectMake(0, viewH*0.9, viewW, viewH*0.1)
        
        //滑块布局
        self.slideLabel.frame = CGRectMake(headButtonW * 0.05, viewH*0.9, headButtonW*0.9, viewH*0.1)
        
    }
    
    private func addHeadButton(title:String?)
    {
        var headButton = UIButton()
        
        headButton.setTitle(title, forState: UIControlState.Normal)
        headButton.setTitleColor(self.normalTitleColor ?? UIColor.blackColor(), forState: UIControlState.Normal)
        headButton.setTitleColor(self.selectedTitleColor ?? UIColor.orangeColor(), forState: UIControlState.Selected)
        
        headButton.addTarget(self, action:Selector("buttonClick:"), forControlEvents: UIControlEvents.TouchUpInside)
        if self.selectedHeadButton == nil
        {
            self.selectedHeadButton = headButton
            if self.hiddenBottom == true
            {
                self.slideLabel.backgroundColor = self.bottomColor ?? UIColor.orangeColor()
            }
            self.selectedHeadButton!.selected = true
        }
        
        self.buttonView.addSubview(headButton)
    }
    
    func buttonClick(button:UIButton)
    {
        if self.selectedHeadButton != button
        {
            turnSelectButton(button)
        }
        
        if let didClick = self.didClick
        {
            didClick()
        }
//        self.delegate?.segmentHeadViewDidClick(self, button: button)
    }
    
    private func turnSelectButton(button:UIButton)
    {
        if self.hiddenBottom == true
        {
            UIView.animateWithDuration(0.4, animations: { () -> Void in
                
                let labelX:CGFloat = button.frame.origin.x + button.frame.size.width*0.05
                let labelY:CGFloat = button.frame.size.height
                let labelW:CGFloat = self.slideLabel.bounds.size.width
                let labelH:CGFloat = self.slideLabel.bounds.size.height
                
                self.slideLabel.frame = CGRectMake(labelX, labelY, labelW, labelH)
            })
        }
        
        self.selectedHeadButton!.selected = false
        button.selected = true
        self.selectedHeadButton = button
    }
    
    func setHeadTitles(titles:[String])
    {
        for title in titles
        {
            addHeadButton(title)
        }
    }
}
