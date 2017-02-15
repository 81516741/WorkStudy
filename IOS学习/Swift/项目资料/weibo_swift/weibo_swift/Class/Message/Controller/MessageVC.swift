//
//  MessageVC.swift
//  weibo_swift
//
//  Created by yh on 16/4/13.
//  Copyright © 2016年 yh. All rights reserved.
//

import UIKit

class MessageVC: BaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        unLoginView.setUnLoginView("visitordiscover_image_message", message: "登录后，别人评论你的微博，发给你的消息，都会在这里收到通知", isHome: false)
        
    }


}
