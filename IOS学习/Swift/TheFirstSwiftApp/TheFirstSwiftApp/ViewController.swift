//
//  ViewController.swift
//  TheFirstSwiftApp
//
//  Created by yh on 16/3/31.
//  Copyright © 2016年 yh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var btn = UIButton.init(frame: CGRectMake(10, 10, 100, 100))
        btn.backgroundColor = UIColor.redColor()
        btn.titleLabel?.text = "nihao"
        btn.addTarget(self, action: #selector(ViewController.good), forControlEvents: UIControlEvents.TouchUpInside)
        self.view .addSubview(btn)
        
    }

    func good() -> Void {
        print("good被点击")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnClick(sender: AnyObject) {
        print("我被点击了")
        let controller = UIAlertController.init(title: "别怕", message: "有我在", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        
        let act = UIAlertAction.init(title: "在我的地盘听我的", style: UIAlertActionStyle.Default) { (_)->Void in
            print("在我地盘")
        }
        
        controller.addAction(act)
        self.presentViewController(controller, animated: true) { 
            print("完成了")
        }
        
    }

}

