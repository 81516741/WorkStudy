//
//  ViewController.swift
//  NetRequest
//
//  Created by ld on 17/3/2.
//  Copyright © 2017年 ld. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      
        
        Alamofire.request("https://api.github.com/users/81516741", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            print(response.request)  // original URL request
            print(response.response) // HTTP URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            print(response.error)   // error
            
            print("Success: \(response.result.isSuccess)")
            print("Response String: \(response.result.value)")
            
            
            if let jsonData = response.data  {
                //这个是data 转成字典
                let jsonDic = JSON(jsonData)
                print(jsonDic["avatar_url"])
                
                //这个是data转成json字符串  和 json字符串转成模型
                if let JSONString = String(data: jsonData, encoding: .utf8) ,let user = Mapper<User>().map(JSONString: JSONString){
                    //用这种方式(if let)产生的数据不是可选类型
                    print(JSONString)
                    print(user.avatar_url)
                }
                
            }
        }
    }
}


class User: Mappable {
    var avatar_url: String!
    var created_at: String!
    var events_url: String!
    var followers_url: String!
    var gravatar_id: String!
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        avatar_url <- map["avatar_url"]
        created_at <- map["created_at"]
        events_url <- map["events_url"]
        followers_url <- map["followers_url"]
        gravatar_id <- map["gravatar_id"]
    }
}

struct Temperature: Mappable {
    var celsius: Double?
    var fahrenheit: Double?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        celsius     <- map["celsius"]
        fahrenheit  <- map["fahrenheit"]
    }
}



