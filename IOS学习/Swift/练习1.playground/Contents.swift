//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
var str1 = "fadsf" as NSString
var str2:NSString  = "ni zai ma "
str2.substringWithRange(NSMakeRange(0, 3))

let a = "this width is"
let b = 12
let c = a + String(12)
c+"\(b)"

for i in 0..<10
{
    print(i)
}

let url = NSURL(string: "http://www.520it.com 好")
var arr15 = [1, 2, 3]
arr15.append(4);
print(arr15)

var arr16 = [1, 2, 3]
arr16 += [4]
// arr16 += 4 以前的版本可以这样写
//arr16 += [5, 6, 7]
arr16 += arr16[0...1] // 还可以自己搞自己
print(arr16)

var range1:Range<Int> = 0...5
//var range2:Range<String>; // 必须遵守ForwardIndexType协议
// start 起点 end 终点
var range3:Range<Int> = Range(start: 0, end: 5)
var range4:Range<Int> = 0..<5
print(range1)
print(range3)
print(range4)