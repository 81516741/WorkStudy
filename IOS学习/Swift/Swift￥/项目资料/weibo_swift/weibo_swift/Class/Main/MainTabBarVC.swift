//
//  MainTabBarVC.swift
//  weibo_swift
//
//  Created by yh on 16/4/13.
//  Copyright © 2016年 yh. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化自控制器
        initSubVC()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //初始化中间的加号按钮
        initAddBtn()
    }
    private func initAddBtn(){
        let width = UIScreen.mainScreen().bounds.size.width/CGFloat(viewControllers!.count)
        let btn = UIButton.init(frame: CGRectMake(0, 0, width, 49))
        btn.frame = CGRectOffset(btn.frame, 2.0 * width, 0)

        btn.setBackgroundImage(UIImage(named:"tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
        btn.addTarget(self, action: #selector(MainTabBarVC.addClick), forControlEvents: UIControlEvents.TouchUpInside)
        tabBar.addSubview(btn)
        
    }
    
    func addClick(){
        print("I did click")
    }
    
    private func initSubVC(){
        let path = NSBundle.mainBundle().pathForResource("MainVCSettings", ofType: "json")
        if let pathValue = path{
            let jsonData = NSData(contentsOfFile: pathValue)
            if let jsonDataValue = jsonData {
                do{
                    let dataDic = try NSJSONSerialization.JSONObjectWithData(jsonDataValue, options: NSJSONReadingOptions.MutableContainers)
                    for dic in dataDic as! [[String:String]] {
                        initChildVC(dic["vcName"]!, title: dic["titleName"]!, imageName: dic["imageName"]!)
                    }
                }catch{
                    initChildVC("HomeVC", title: "首页", imageName: "tabbar_home")
                    initChildVC("DiscoveryVC", title: "发现", imageName: "tabbar_discover")
                    initChildVC("NullViewController", title: "", imageName: "")
                    initChildVC("MessageVC", title: "消息", imageName: "tabbar_message_center")
                    initChildVC("ProfileVC", title: "我", imageName: "tabbar_profile")
                }
            }
        }
    }
    
    private func initChildVC(VCName:String,title:String,imageName:String){
        let paceName = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        let childVCClass:AnyClass? = NSClassFromString(paceName + "." + VCName)
        let childVCType = childVCClass as! UIViewController.Type
        let childVC = childVCType.init()
        let navVC = MainNavigationVC()
        navVC.addChildViewController(childVC)
        childVC.title = title
        childVC.tabBarItem.image = UIImage.init(named: imageName)
        childVC.tabBarItem.selectedImage = UIImage.init(named: imageName + "_highlighted")
        self.addChildViewController(navVC)
    }

}
