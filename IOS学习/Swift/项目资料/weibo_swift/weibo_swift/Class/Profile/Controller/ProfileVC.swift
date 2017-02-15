//
//  ProfileVC.swift
//  weibo_swift
//
//  Created by yh on 16/4/13.
//  Copyright © 2016年 yh. All rights reserved.
//

import UIKit


class ProfileVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        unLoginView.setUnLoginView("visitordiscover_image_profile", message:  "登录后，你的微博、相册、个人资料会显示在这里，展示给别人", isHome: false)
        
    }


}
