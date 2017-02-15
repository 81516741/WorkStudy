//
//  ViewController.swift
//  单例
//
//  Created by yh on 16/7/19.
//  Copyright © 2016年 ld. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let a = Manager.shareInstance
        print( Manager.myStruct().你妹 { (firstName) -> (String) in
            return firstName + Manager.myStruct().lastName
            })
        a.printSomething()
        
    }


}

