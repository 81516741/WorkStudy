//
//  MyView.swift
//  测试从xib加载view
//
//  Created by ld on 16/7/7.
//  Copyright © 2016年 ld. All rights reserved.
//

import UIKit

class MyView: UIView {

    
    @IBOutlet weak var btn: UIButton!
    
    override func awakeFromNib()
    {
        let view = NSBundle.mainBundle().loadNibNamed("MyView", owner: self, options: nil).last as! UIView
        view.frame = self.bounds
        addSubview(view)
    }
    
    func myView() -> MyView {
        let view = NSBundle.mainBundle().loadNibNamed("MyView", owner: self, options: nil).last as! UIView
        addSubview(view)
        return self
    }
    
    func logSomething(str:String) -> Void {
        print(str)
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
