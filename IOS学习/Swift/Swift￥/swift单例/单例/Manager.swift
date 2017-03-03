//
//  Manager.swift
//  单例
//
//  Created by yh on 16/7/19.
//  Copyright © 2016年 ld. All rights reserved.
//

import Foundation

public class Manager{
    
   public static let shareInstance : Manager = Manager()

   public struct myStruct {
    
        let lastName:String = "lastName:lingda"
    
        public func 你妹(block:((String)->(String))) -> String {
           return block("firstName:zeng")
        }
    }
   
    func printSomething() {
        print("你在做什么")
    }
    
}
