//
//  MyTabBar.swift
//  Tabbar自定义测试
//
//  Created by ld on 16/7/10.
//  Copyright © 2016年 ld. All rights reserved.
//

import UIKit

protocol MyTabBarDelegate:NSObjectProtocol {
    func addClick(btn:UIButton)
}

class MyTabBar: UITabBar {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    weak var myDelegate:MyTabBarDelegate?
    var addBtn:UIButton?
    var itemCount = CGFloat(3)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("我被加载了")
        addBtn = UIButton()
        addBtn!.setImage(UIImage(named: "add"), forState: UIControlState.Normal)
        addBtn?.contentMode = UIViewContentMode.ScaleAspectFit
        addBtn?.contentEdgeInsets = UIEdgeInsets.init(top: 60, left: 30, bottom: 0, right: 30)
        addBtn?.addTarget(self, action: #selector(popAction), forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(addBtn!)
    }
    func popAction () {
        myDelegate?.addClick(addBtn!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        print(point)
        let itemWidth = UIScreen.mainScreen().bounds.width/itemCount
        if (point.x > itemWidth+30 && point.x < itemWidth * 2-30) && (point.y < 44 && point.y > 44 - itemWidth + 60) {
            return addBtn!
        }
        return super.hitTest(point, withEvent: event)
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        let itemWidth = UIScreen.mainScreen().bounds.width/itemCount
        addBtn?.frame = CGRectMake(center.x - itemWidth * 0.5, 44-itemWidth, itemWidth, itemWidth)
        bringSubviewToFront(addBtn!)
        var i = CGFloat(0)
        for subView in subviews {
            print(subView)
            if subView.isKindOfClass(NSClassFromString("UITabBarButton")!) {
                if i == 1 {
                    i = i + 1
                }
                subView.frame = CGRectMake(i * itemWidth, 0, itemWidth, 44)
                i = i + 1
            }
        }
    }

}
