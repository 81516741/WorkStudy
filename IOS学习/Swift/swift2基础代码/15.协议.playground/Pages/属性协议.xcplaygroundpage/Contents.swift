//: 属性协议：顾名思义，要求遵从者实现以指定的名称实现属性，但具体实现是实例属性或类型属性并不关心。
//:  - 可以指定要求实现getter 或 getter+setter。 属性必须定义为变量，var。
//实例属性协议
protocol 某协议{
    var 必须是读写: Int { get set }
    var 只读: Int { get }
}

//类型属性协议
protocol 另一个协议 {
    static var 某类型属性: Int { get set }
}

//:  - 遵从实例属性协议🌰1
protocol 全名 {
    var 姓: String { get }
    var 名: String { get }
}

struct 学生: 全名 {
    var 姓: String
    var 名: String
}

var 学生1 = 学生(姓: "小", 名: "波")
学生1.名
学生1.姓


//:  - 遵从实例属性协议🌰2
class 人物: 全名 {
    var 名头: String?
    var 人物名: String
    
    init(名头:String?, 人物名: String) {
        self.名头 = 名头
        self.人物名 = 人物名
    }
    
    var 姓: String {
        return 名头 ?? ""
    }
    
    var 名: String {
        return 人物名
    }
}

var 人物1 = 人物(名头: "战神", 人物名: "小波")

人物1.姓
人物1.名
//: [方法协议](@next)
