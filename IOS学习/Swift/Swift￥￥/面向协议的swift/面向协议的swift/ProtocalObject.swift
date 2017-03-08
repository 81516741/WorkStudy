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



// 这里用面向协议的方式去封装网络请求API
struct User {
    init?(data:Data) {
    }
}
protocol Decodable {
    static func parse(data: Data) -> Self?
}
extension User: Decodable {
    static func parse(data: Data) -> User? {
        return User(data: data)
    }
}

enum HTTPMethod: String {
    case GET
    case POST
}

protocol Request {
    var path:String {get}
    var method:HTTPMethod {get}
    var parameter:[String:Any] {get}
    associatedtype Response:Decodable
}

struct UserRequest:Request {
    var path: String {
        return "/path"
    }
    var method: HTTPMethod = .GET
    var parameter: [String : Any] = ["":""]
    typealias Response = User
}


protocol Client {
    func send<T:Request>(_ r: T, handler: @escaping (T.Response?) -> Void)
    var host: String {get}
}

struct LocaleClient:Client {
    var host: String = "www.baidu.com"
    func send<T : Request>(_ r: T, handler: @escaping (T.Response?) -> Void) {
        let url = URL(string: host.appending(r.path))
        print("发送请求\(url)")
    }
}




