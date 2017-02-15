//
//  ViewController.swift
//  懒加载
//
//  Created by ld on 16/4/6.
//  Copyright © 2016年 ld. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var dateList:[String] = {
        print("我被搞了")
        return ["好","不好","在吗"]
    }()
    
    
    let bibao = {
        ()->[String] in
        print("我被搞了")
        return ["好","不好","在吗"]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dateList)
        print(dateList)
        print(dateList)
    }


}

