//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var a :Character = "a"
var b = "好dd"
var c = "你在做什么"

for x in c.characters{
    print(x)
}
c = b + c
c.append(a)
c

let name = "旅客\(c)在搞飞机"
"\u{5154}"
c.characters.count
c.characters.indexOf("n")
c.characters.endIndex.predecessor().predecessor()
c[c.startIndex.successor()]
c[c.endIndex.advancedBy(-3)]
c[c.startIndex.advancedBy(3)]
c.characters[c.startIndex.advancedBy(3)]
c[c.startIndex.advancedBy(3, limit: name.characters.startIndex.advancedBy(1))]

var name1 = "小波说雨燕!"
var name2 = "之swift"
name1.insertContentsOf(name2.characters, at: name1.characters.endIndex.predecessor())
name1.removeAtIndex(name1.endIndex.predecessor())

let range = name1.endIndex.advancedBy(-(name2.characters.count))..<name1.endIndex
name1.removeRange(range)
name1.hasPrefix("小")
name2.hasSuffix("就")
var name3 : Array<String>
let name4 : [String]

var shuzu = ["哈哈","nihao","zaima","laiba"]
var shuzu1 = ["nihhh","3333","34545"]
shuzu += shuzu1
shuzu.count
shuzu.isEmpty
shuzu.removeRange(1...3)
shuzu.count

let setTest : Set = [3,4,5,4]
let setText1 : Set = [3,5,6]
setText1.isSubsetOf(setTest)
setText1.isStrictSubsetOf(setTest)
assert(setTest.count == 3, "dni")
setText1.exclusiveOr(setTest)
setText1.sort()

var zidian : [String:String]
zidian = ["nihao":"haodehen","nizaima":"buzai"]

for x in zidian.keys{
    print(x)
}

for (x1,x2) in zidian{
    print(x1,x2)
}

let shuzuha = [String](zidian.keys)

var result = 1
for x in 1...100{
    result += x;
}
result

for _ in 1...10{
    print("曾令达")
}

var tianqi = "hao"
switch tianqi{
case "hao":
    print("hao")
case "buhao":
    print("buhao")
default: break
}

let bianliang = 8
switch bianliang{
case 1...2:
    print("zai 1...10 zhijian")
default:break
}

var zuobiao = (x:8,y:8)

switch zuobiao{
case(let x, let y) where x == y:
    print("在45°对角线上")
default:break
}

switch zuobiao{
    case (1...10,1...10) where zuobiao.x == zuobiao.y:
    print("zai")
default: break
}

var 元组 = (x:15 ,y:15 ,z:15)

switch 元组{
case(let x,let y,let z) where x == y && y == z:
    print("在对角线上")
default :
    print("不在对角线上")
    break
}

switch 元组{
case(1...14,1...15,1...15) where 元组.x == 元组.y && 元组.y == 元组.z:
    print("在1..15对角线上")
default :
    print("不在1..15在对角线上")
    break
}

func add(a:Int,b:Int)->Int
{
    return a + b
}

add(10,b:20)

print(add(39, b: 29))

func sum(numbers:Int...)->Int
{
    var result = 0
    for number in numbers{
        result += number
    }
    return result
}

sum(1,2,3)



