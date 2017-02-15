//
//  BaseVC.swift
//  weibo_swift
//
//  Created by ld on 16/4/16.
//  Copyright © 2016年 yh. All rights reserved.
//

import UIKit

class BaseVC: UIViewController
{
    var isLogin = false
    
    lazy var unLoginView:UnLoginView = {
        var tempView = NSBundle.mainBundle().loadNibNamed("UnLoginView", owner: nil, options: nil).last as! UnLoginView
        tempView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.height)
        tempView.delegate = self
        return tempView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        if isLogin {
            unLoginView.removeFromSuperview()
        }else{
            view.addSubview(unLoginView)
        }
    }
    func addUnloginView(){
        
    }
}

extension BaseVC : UnLoginViewDelegate
{
    //MARK: - 代理方法
    func unLoginViewLoginBtnClick(){
        print("login did click")
    }
    func unLoginViewRegisterBtnClick(){
        print("register did click")
    }
    
}
