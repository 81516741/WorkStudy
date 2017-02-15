//
//  ViewController.swift
//  表情键盘的封装-swift
//
//  Created by yh on 16/5/27.
//  Copyright © 2016年 ld. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let path = NSBundle.mainBundle().pathForResource("emoticons.plist", ofType: nil, inDirectory: "Emoticons.bundle")
        let dic = NSDictionary(contentsOfFile: path!)
        let emotionArr = dic!["packages"] as! NSArray
        Model.mj
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

