//: 闭包表达式
//:
//: ----
//:  - 有时候需要更简洁的使用函数的方式
//:  - 尤其是一个函数的某参数是另一个函数时
//:  - 这节主要以sort函数为例
//: ----
let city = ["上海","New York","London","北京","Tokyo"]
//: ----
//:  - sort函数用于对数组排序, 只接受一个参数, 此参数描述2个元素先后的逻辑。
func 倒序(a: String, b: String) -> Bool {
    return a > b
}

倒序("London", b: "Tokyo")

let city1 = city.sort(倒序)


//:  - 🌰完整版逻辑, 可包装于函数中：


//:  - 用闭包表达式来改写：
let city2 = city.sort({(a: String, b: String) -> Bool in
    return a > b
})

//:  闭包的自动推断
//:  - ①参数和返回类型可自动推断
let city3 = city.sort { (a, b)  in
    return a > b
}
//:  - ②单表达式可以忽略return关键词
let city4 = city.sort { (a, b)  in
    a > b
}
//:  - ③可使用快捷参数,前缀$+数字,从0开始递增
let city5 = city.sort {
    $0 > $1
}
//:  可尾随
//:  - 当闭包是最后一个参数时，可把整个闭包置于参数列表之后
let city6 = city.sort() { $0 > $1}

//:  ⭐️操作符函数
//:  - 还可以进一步缩短，因为 > 操作符，可以自动推断参数。
let city7 = city.sort(>String)


