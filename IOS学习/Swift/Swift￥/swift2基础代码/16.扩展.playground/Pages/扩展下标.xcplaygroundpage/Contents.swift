//: 扩展下标: 给已有类型加上一个新下标.

//: - 对整数加从右往左的索引下标
//🌰 123456789[2] 算法,除以100,对10求余数, 就是7

extension Int {
    subscript(var index: Int) -> Int {
        var base = 1
        
        for _ in 1...index {
            base *= 10
        }
        
        return self / base % 10
    }
}
123456789[2]

//: [扩展嵌套类型](@next)
