//
//  ViewController.swift
//  面向协议的swift
//
//  Created by ld on 17/3/2.
//  Copyright © 2017年 ld. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        var a : [Animal] {return [Animal(name:"caocao")]}
        var str : String {return "default string"}
        super.viewDidLoad()
        print(Animal(name:"nihao").name)
        Animal(name:"caocao").bigEat()
        
        LocaleClient().send(UserRequest()) { user in
            
        }
    }
}




