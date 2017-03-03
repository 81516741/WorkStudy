//
//  ProtocalObject.swift
//  面向协议的swift
//
//  Created by ld on 17/3/2.
//  Copyright © 2017年 ld. All rights reserved.
//

import UIKit

struct Animal:Cat,Dog {
    let name: String
}

protocol Cat {
    var name:String{get}
    func bigEat()
}

protocol Dog {
    func bigEat()
}
//通过扩展协议提供默认实现 解决横切关注点问题
extension Cat {
    func bigEat() {
        print(name)
    }
}

//打开就需要在Animal实现bigEat方法(菱形缺陷)
//extension Dog {
//    func bigEat() {
//        print("ddd")
//    }
//}
