//
//  ViewController.swift
//  一个方法的测试
//
//  Created by yh on 16/5/18.
//  Copyright © 2016年 ld. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var rowCache: [Int: CGFloat] = [Int: CGFloat]()
    var arr:[Int] = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        rowCache[23] = 88
        rowCache[33] = 99
        arr.append(33)
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print(rowCache[23])
        print(rowCache[33])
        print(arr.first)
    }

}

