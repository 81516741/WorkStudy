//
//  Extention.swift
//  weibo_swift
//
//  Created by ld on 16/5/9.
//  Copyright © 2016年 yh. All rights reserved.
//

import UIKit

extension UIBarButtonItem
{
   class func creatBarButtonItem(imageName:String,target:AnyObject?, selector:Selector) -> UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: .Highlighted)
        btn.addTarget(target, action: selector, forControlEvents: .TouchUpInside)
        btn.sizeToFit()
        return UIBarButtonItem.init(customView: btn)
    }
}