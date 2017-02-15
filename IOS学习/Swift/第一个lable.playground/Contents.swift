//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

let label = UILabel.init(frame: CGRectMake(0, 0, 200, 50))
label.text = "点击购买"
label.textColor = UIColor.redColor()
label.textAlignment = NSTextAlignment.Center
label.backgroundColor = UIColor.blueColor()
label.layer.cornerRadius = 20
label.clipsToBounds = true
label
