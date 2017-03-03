//: 类型属性 :属于类型本身,通用于任何实例,所以总是有默认值.
//: - ⚠️对于类, 计算型的类型属性,前面要加关键字class. 可被子类重写(override)
class 生命体 {
    class  var 遗传方式 :String {
        return "RNA"
    }
    
}

class Human: 生命体 {
    override class var 遗传方式: String {
        return "DNA"
    }
}

生命体.遗传方式
Human.遗传方式



//: - 💡结构体和枚举, 关键字 static
struct 逛街 {
    static let 最大负载 = 30
    static let 试衣间 = "UNIClO"
    static let 网站 = "http://www.taobao.com/shopname="
    var 参数 = ""
    
    var 请求网址 : String {
        return 逛街.网站 + 参数
    }
}

逛街.试衣间

let 逛淘宝 = 逛街(参数: "生鲜")

逛淘宝.请求网址

//: [](@next)
