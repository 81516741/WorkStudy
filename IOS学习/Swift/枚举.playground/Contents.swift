//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//枚举1
enum weather{
    case hao
    case cha
    case buhaobucha
}

weather.buhaobucha

let todayWeather = weather.hao

switch todayWeather{
case weather.hao:
    print("hao")
case .cha:
    print("cha")
case .buhaobucha:
    print("不好不差")
}

/*:
 枚举2 -- 很精确的 高级枚举
*/

enum exactWeather {
    case rain(String,String)
    case sun(String,String,String)
}

let nanNing = exactWeather.rain("毛毛雨", "不太冷")
let guanZhuang = exactWeather.sun("蓝蓝的天空", "白白的云", "天空还下着雪")

switch nanNing{
case .rain(let x,let y):
    print(x+y)
case exactWeather.sun(let x,let y,let z):
    print(x+y+z)
}

switch guanZhuang{
case .rain(let x,let y):
    print(x+y)
case exactWeather.sun(let x,let y,let z):
    print(x+y+z)
}

"哈哈哈\(str)"


enum person{
    case height(level: String,number:NSNumber)
    case age(state:String,number:String)
}

let xiaoming = person.height(level: "tall", number: NSNumber.init(int: 168))






