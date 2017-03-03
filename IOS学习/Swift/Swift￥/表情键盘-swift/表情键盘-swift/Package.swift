//
//  Pakages.swift
//  表情键盘-swift
//
//  Created by yh on 16/5/30.
//  Copyright © 2016年 ld. All rights reserved.
//

import UIKit

class Package: NSObject {
    
    var id : String?{
        didSet{
            let info = emotionInfo()
            let emotionArr = info["emoticons"] as? NSArray
            group_name_cn = info["group_name_cn"] as? String
            emoticons = Emotion.Emotions(emotionArr!, id: id!,group_name_cn: group_name_cn!)
        }
    }
    
    var group_name_cn : String?
    
    var emoticons : [Emotion]?
    
    class func loadPakages()->[Package]{
        var pakages = [Package]()
        //创建最近表情
        let recentPakage = Package(group_name_cn: "最近")
        recentPakage.appendEmtyEmotion()
        pakages.append(recentPakage)
        //从本地文件中加载表情数据
        let pakagesDicArr = Package.loadPackagesPlist()
        for dic in pakagesDicArr {
            let pakage = Package.packageWithDic(dic as! NSDictionary)
            //不加这两句，系统不调用didSet方法，kvc不调用
            let id = pakage.id
            pakage.id = id
            pakage.appendEmtyEmotion()
            pakages.append(pakage)
        }
        return pakages;
    }
    
    func appendEmtyEmotion(){
        let count = emoticons?.count ?? 0
        let restCount = 21 - (count%21)
        for _ in 0..<restCount {
            emoticons?.append(Emotion(isDeleBtn: false))
        }
        emoticons?.removeLast()
        emoticons?.append(Emotion(isDeleBtn: true))
    }
    
    // MARK:- 加载本地plist
    class func loadPackagesPlist() -> NSArray{
        let path = NSBundle.mainBundle().pathForResource("emoticons.plist", ofType: nil, inDirectory: "Emoticons.bundle")
        let dicArr = NSDictionary(contentsOfFile: path!)
        let pakagesDicArr = dicArr!["packages"] as! NSArray
        return pakagesDicArr
    }
    
    class func emotionPath()-> NSString {
        return (NSBundle.mainBundle().bundlePath as NSString).stringByAppendingPathComponent("Emoticons.bundle")
    }
    
    func emotionInfo() -> NSDictionary {
        return NSDictionary(contentsOfFile: (Package.emotionPath().stringByAppendingPathComponent(id!) as NSString).stringByAppendingPathComponent("info.plist"))!
    }
    //这么字典转模型是为了调用didset方法，在init里面调用不了
    class func packageWithDic(dic:NSDictionary) -> Package {
        let emotion = Package()
        emotion.id = dic["id"] as? String
        return emotion
    }
    
    override init() {
        super.init()
    }
    
    init(group_name_cn:String) {
        super.init()
        self.group_name_cn = group_name_cn
        self.emoticons = [Emotion]()
    }
    
    override func setValue(value: AnyObject?, forKey key: String) {
        
    }
}
// MARK: - 模型
class Emotion: NSObject {
    //emoji表情16进制 code
    var code : String?{
        didSet{
            // 1.从字符串中取出十六进制的数
            // 创建一个扫描器, 扫描器可以从字符串中提取我们想要的数据
            
            if code == nil {
                return
            }
            let scanner = NSScanner(string: code!)
            
            // 2.将十六进制转换为字符串
            var result:UInt32 = 0
            scanner.scanHexInt(&result)
            
            // 3.将十六进制转换为emoji字符串
            emojiStr = "\(Character(UnicodeScalar(result)))"
        }
    }

    //emoji表情字符串
    var emojiStr : String?    //普通表情的描述
    var chs : String?
    //普通表情的图片名称
    var png : String?{
        didSet{
            if png == nil {
                return
            }
           pngPath = (Package.emotionPath().stringByAppendingPathComponent(id!) as NSString).stringByAppendingPathComponent(png!)
        }
    }
    //普通表情的图片地址
    var pngPath : String?
    //表情所属包
    var id : String?
    //表情类型
    var group_name_cn : String?
    //是否是删除键
    var isDeleBtn : Bool?
    
    class func Emotions(dicArr:NSArray, id:String, group_name_cn:String)->[Emotion] {
        var emotions = [Emotion]()
        var index = 0
        for dic in dicArr {
            if index == 20 {
                index = 0
                emotions.append(Emotion(isDeleBtn: true))
            }
            let emotion = Emotion.emotionWith(dic as! NSDictionary, id: id, group_name_cn: group_name_cn)
            emotions.append(emotion)
            index += 1
        }
        return emotions;
    }
    //模型转字典，他奶奶的kvc不好使，而且写在init方法里面不会调用属性的didset方法
    class func emotionWith(dic:NSDictionary,id:String,group_name_cn:String)->Emotion {
        let emotion = Emotion(isDeleBtn: false)
        emotion.id = id
        emotion.group_name_cn = group_name_cn
        emotion.code = dic["code"] as? String
        emotion.chs = dic["chs"] as? String
        emotion.png = dic["png"] as? String
        return emotion
    }
    
    init(isDeleBtn:Bool) {
        super.init()
        self.isDeleBtn = isDeleBtn
    }
}
