//: Playground - noun: a place where people can play

import Foundation

//MARK : 好的一种判断多个条件是否都成立的方法

struct Good:OptionSetType {
    let rawValue: Int
    static let name     =   Good(rawValue : 1)
    static let phone    =   Good(rawValue : 1 << 1)
    static let age      =   Good(rawValue : 1 << 2)
}

extension Good{
    func isAllOK()->Bool{
        let count = 3
        var found = 0
        for time in 0..<count where contains(Good(rawValue:1 << time)) {
          found = found + 1
        }
        return count == found
    }
}

var possibleGood:Good = []
possibleGood.unionInPlace(.name)
possibleGood.isAllOK()
possibleGood.unionInPlace(.phone)
possibleGood.isAllOK()
possibleGood.unionInPlace(.age)
possibleGood.isAllOK()
possibleGood.subtractInPlace(.age)
possibleGood.isAllOK()


