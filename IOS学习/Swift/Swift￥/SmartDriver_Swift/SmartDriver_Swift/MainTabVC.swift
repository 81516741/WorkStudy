//
//  MainTabVC.swift
//  SmartDriver_Swift
//
//  Created by yh on 16/6/8.
//  Copyright © 2016年 ld. All rights reserved.
//

import UIKit

class MainTabVC: UITabBarController {
    override func viewDidLoad() {
       addSubView(CarControlVC(), title: "车控", imageName: "1")
        addSubView(MoreVC(), title: "更多", imageName: "2")
       
    }
    
    func addSubView(vc:UIViewController,title:String,imageName:String) -> Void
    {
        vc.title = title
        let nav1 = MainNavVC(rootViewController: vc)
        vc.tabBarItem.image = UIImage(named:imageName)
        addChildViewController(nav1)
    }
}
