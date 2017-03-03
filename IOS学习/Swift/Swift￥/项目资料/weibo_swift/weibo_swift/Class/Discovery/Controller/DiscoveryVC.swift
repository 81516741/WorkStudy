//
//  DiscoveryVC.swift
//  weibo_swift
//
//  Created by yh on 16/4/13.
//  Copyright © 2016年 yh. All rights reserved.
//

import UIKit

class DiscoveryVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        isLogin = true
        unLoginView.setUnLoginView("visitordiscover_image_message", message: "登录后，最新、最热微博尽在掌握，不再会与实事潮流擦肩而过", isHome: false)
    }

}
