//
//  ViewController.swift
//  闭包创建scrollView
//
//  Created by yh on 16/4/7.
//  Copyright © 2016年 yh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let sc = createdScrollView({ () -> Int in
            return 18
            }) { (index) -> (UIView) in
                let label = UILabel.init(frame: CGRectMake(50 * CGFloat(index), 0, 50, 44))
                label.text = "No.\(index)"
                label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(self.tap)))
                label.userInteractionEnabled = true
                return label
        }
        view.addSubview(sc)
        
    }

    func tap(){
        print("我被点击了,哈哈哈")
    }
    func createdScrollView(btnCount:()->Int,viewWithIndex:(index:Int)->(UIView)) -> UIScrollView {
        let sc = UIScrollView.init(frame: CGRectMake(0, 100, view.bounds.size.width, 44))
        sc.backgroundColor = UIColor.yellowColor()
        for x in 0..<btnCount() {
            let btn = viewWithIndex(index: x)
            sc.addSubview(btn)
        }
        sc.contentSize.width = CGFloat(50 * btnCount())
        return sc
    }
}

