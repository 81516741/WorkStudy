//
//  PresentaionC.swift
//  weibo_swift
//
//  Created by ld on 16/5/9.
//  Copyright © 2016年 yh. All rights reserved.
//

import UIKit

class PresentaionC: UIPresentationController {

    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
        //因为presentingViewController是野指针，所以打印蹦掉
        //这个函数主要是看看presentingViewController 和presentedViewController
//        print(presentingViewController)
        print(presentedViewController)
    }
    
    override func containerViewWillLayoutSubviews() {
        containerView?.insertSubview(hudView, atIndex: 0)
        presentedView()?.frame = CGRectMake(50, 50, 200, 200)
    }
    
    //MARK:  - 懒加载
    private lazy var hudView : UIView = {
        let view = UIView.init(frame: UIScreen.mainScreen().bounds)
        view.backgroundColor = UIColor.init(white: 0, alpha: 0.2)
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(PresentaionC.close)))
        return view
    }()
    
    func close(){
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
