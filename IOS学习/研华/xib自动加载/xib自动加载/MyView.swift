//
//  MyView.swift
//  xib自动加载
//
//  Created by yh on 16/8/9.
//  Copyright © 2016年 ld. All rights reserved.
//

import UIKit

class MyView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    weak var myView :UIView!
    
    override func awakeFromNib() {
        let viewXib = NSBundle.mainBundle().loadNibNamed("MyView", owner: self, options: nil).last as! UIView
        myView = viewXib
        addSubview(viewXib)
    }
    
    override func layoutSubviews() {
        myView.frame = bounds
    }

}
