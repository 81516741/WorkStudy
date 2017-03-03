//
//  ViewController.swift
//  Tabbar自定义测试
//
//  Created by ld on 16/7/10.
//  Copyright © 2016年 ld. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "我就是one"
        tabBarController?.setValue(MyTabBar(), forKey: "tabBar")
        let myTabBar = tabBarController?.tabBar as! MyTabBar
        myTabBar.myDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController:MyTabBarDelegate
{
    func addClick(btn: UIButton) {
        print(btn)
        let vc = UIAlertController.init(title: "你好", message: "这是消息", preferredStyle: UIAlertControllerStyle.Alert)
       let alter = UIAlertAction.init(title: "是诗歌alter", style: UIAlertActionStyle.Destructive) { (_) in
            print("弹出")
        }
        vc.addAction(alter)
        self.presentViewController(vc , animated: true) { 
            print("我被弹出了，完毕")
        }
    }
}
