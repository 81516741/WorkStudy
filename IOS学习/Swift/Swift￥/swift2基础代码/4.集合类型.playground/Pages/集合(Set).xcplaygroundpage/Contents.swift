//: 集合(Set): 值无序不重复. 

//:  - 定义: Set<元素类型>
//let 群友身份证号 : Set<String>

//:  - 用数组字面量创建集合
var 一群友身份证号 : Set<String> = ["123", "456", "789", "12X", "123"]


//:  - 虽定义无法使用类型推断, 但可以把类型省略不写,只保留 :Set
var 二群友身份证号 : Set = ["333", "456", "666", "12X", "091"]

//:  - ①元素计数: count, 空否: isEmpty
一群友身份证号.count
二群友身份证号.isEmpty

//:  - ②↙️插入:insert
一群友身份证号.insert("34X")
//:  - ③↗️移除:remove
二群友身份证号.remove("091")

二群友身份证号


//:  - ④是否包含某元素:contains
二群友身份证号.contains("777")

//:  - ⑤转换为数组:sort
let 二群友身份证号数组 = 二群友身份证号.sort()

//:  - 集合操作: 交差并补
集合操作()

//:  - 1⃣️交集 intersect
一群友身份证号.intersect(二群友身份证号)



//:  - 2⃣️差集 subtract
一群友身份证号.subtract(二群友身份证号)

//:  - 3⃣️并集 union
一群友身份证号.union(二群友身份证号)


//:  - 4⃣️补集 exclusive
一群友身份证号.exclusiveOr(二群友身份证号)

//:  - 集合关系
集合关系()


//:  - 💡相等: 两个集合有完全相同的元素.
let set1 : Set = [1,2,3,4,5]
let set4 : Set = [5,2,3,4,1]

let set100 : Set = [100,101,102]

let set2 : Set = [4,5,6,7,8]

let set3 : Set = [1,2,3,4,5,4,5,6,7,8]
//:  - 1⃣️子集: isSubsetOf(可以相等), 严格子集isStrictSubsetOf
set1.isSubsetOf(set3)

set1.isSubsetOf(set4)
set1.isStrictSubsetOf(set4)
//:  - 2⃣️父集: isSupersetOf(可以相等), 严格父集isStrictSuperSetOf
set3.isSupersetOf(set1)
set3.isSupersetOf(set2)

set3.isStrictSupersetOf(set1)

//:  - 3⃣️无交集: isDisjointWith
set1.isDisjointWith(set100)

set1.isDisjointWith(set2)
//: [字典](@next)
