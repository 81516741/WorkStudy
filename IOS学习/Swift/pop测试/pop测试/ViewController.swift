//
//  ViewController.swift
//  pop测试
//
//  Created by yh on 16/6/8.
//  Copyright © 2016年 ld. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {

        let animation = POPSpringAnimation()
        animation.toValue = NSValue(CGRect: CGRectMake(0, 0, 400, 400))
        let popVC = PopViewVC()
        popVC.view.layer.pop_addAnimation(animation, forKey: "myKey")
        self.presentViewController(popVC, animated: true, completion: nil)
    }


}

