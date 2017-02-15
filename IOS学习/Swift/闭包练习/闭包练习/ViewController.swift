//
//  ViewController.swift
//  闭包练习
//
//  Created by ld on 16/4/6.
//  Copyright © 2016年 ld. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       let sc = creatScrollViewWith({ () -> Int in
            return 16
            }) { (index) -> UIView in
                let lable = UILabel.init(frame: CGRectMake(50 * CGFloat(index), 0, 50, 44))
                lable.text = "No."
                return lable
        }
        view.addSubview(sc)
        
    }
    func creatScrollViewWith(count:() -> Int,viewWithIndex:(index:Int)->UIView)->UIScrollView
    {
        let sc = UIScrollView.init(frame: CGRectMake(0, 88, view.bounds.size.width, 44))
        sc.backgroundColor = UIColor.redColor()
        sc.contentSize.width = CGFloat(count()) * 50.0
        for x in 0..<count() {
            sc.addSubview(viewWithIndex(index: x))
        }
        return sc
    }

}

