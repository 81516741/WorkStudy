//
//  ViewController.swift
//  表情键盘-swift
//
//  Created by yh on 16/5/30.
//  Copyright © 2016年 ld. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func jump(sender: AnyObject) {
        self.navigationController?.pushViewController(EmotionVC(), animated: true)
    }

}


