//: Playground - noun: a place where people can play

import UIKit

// 函数作为参数
print("jajaj")

func add (a:(Int,Int)->Int,b:Int,c:Int)->Int
{
    return a(b,c)
}

//函数作为参数传递
func plus (a:Int ,b:Int)->Int
{
   return a * b
}
add(plus, b: 9, c: 9)

//闭包函数作为参数传递,闭包只有一行代码可以省略return
add({(a:Int,b:Int)->Int in
    a+b
    }, b: 7, c: 4)



//函数作为返回值
func add1 (a:(Int,Int)->Int,b:Int,c:Int)->(Int,Int)->Int
{
    a(b,c)
    return plus
}

add1({(a:Int,b:Int)->Int in
    a + b
    }, b: 10, c: 11)(11,11)

//闭包

var arr = ["adot","mack","jack","lucy","luck","中文","god"]

arr.sort()

//函数作为条件排序
func revert(a:String,b:String)->Bool
{
    return a > b
}
arr.sort(revert)

//闭包作为条件排序
arr.sort{(a:String,b:String)->Bool in
    a<b
}
//自动推断
arr.sort { (a, b) in
    a<b
}

arr.sort{
    $0 > $1
}

arr.sort(){
    $0 > $1
}
//超级简写
arr.sort(>)


//复习
func sumAll(function:(c:Int,d:Int)->String,name:String)->(String,String)->String
{
    return {(a:String,b:String)->String in
        a + b + name + function(c: 13,d: 14)
    };
}

sumAll({(a:Int,b:Int) -> String in
    return "\(a)\(b)"
    }, name: "你")("我","爱");



