//
//  ViewController.swift
//  测试从xib加载view
//
//  Created by ld on 16/7/7.
//  Copyright © 2016年 ld. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let view1 = MyView().myView()
        view1.logSomething("dfas")
        view.addSubview(view1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

