//
//  EmotionVC.swift
//  表情键盘-swift
//
//  Created by yh on 16/5/30.
//  Copyright © 2016年 ld. All rights reserved.
//

import UIKit

let LDEmotionCellReuseID = "LDEmotionCellReuseID"

class EmotionVC:UIViewController{
    override func viewDidLoad() {
        configUI()
    }
    
    func configUI(){
        view.backgroundColor = UIColor.whiteColor()
        view.addSubview(collectionView)
    }
    
    //MARK:- Emotion的懒加载
    private lazy var collectionView:UICollectionView = {
        var collectionView = UICollectionView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 260), collectionViewLayout: EmotionLayout())
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.registerClass(EmotionCell.self, forCellWithReuseIdentifier: LDEmotionCellReuseID)
        return collectionView
    }()
}

class EmotionCell: UICollectionViewCell {
    
    var emotion:Emotion?{
        didSet{
            if emotion?.emojiStr != nil {
                emotionBtn.setTitle(emotion?.emojiStr, forState: .Normal)
            }else{
                emotionBtn.setTitle(nil, forState: .Normal)
            }
            if emotion?.pngPath != nil {
                emotionBtn.setImage(UIImage(contentsOfFile:emotion!.pngPath!), forState: .Normal)
            }else{
                emotionBtn.setImage(nil, forState: .Normal)
            }
            if (emotion!.isDeleBtn!){
                emotionBtn.setImage(UIImage(named:"compose_emotion_delete"), forState: .Normal)
                emotionBtn.setImage(UIImage(named:"{compose_emotion_delete_highlighted"), forState: .Highlighted)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    func configUI(){
        contentView.addSubview(emotionBtn)
        contentView.backgroundColor = UIColor.yellowColor()
        //布局
        emotionBtn.frame = contentView.bounds
        emotionBtn.frame = CGRectInset(contentView.bounds, 4, 4)
    }
    
    
    //MARK:- EmotionCell的懒加载
    lazy var emotionBtn:UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.redColor()
        btn.titleLabel?.font = UIFont.systemFontOfSize(32)
        btn.userInteractionEnabled = false
        return btn
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class EmotionLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        let itemWH = UIScreen.mainScreen().bounds.width / 7.0
        itemSize = CGSizeMake(itemWH, itemWH)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .Horizontal
        collectionView?.pagingEnabled = true
    }
}
//MARK:- 代理方法
extension EmotionVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return Package.loadPakages().count
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (Package.loadPakages()[section]).emoticons!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(LDEmotionCellReuseID, forIndexPath: indexPath) as! EmotionCell
        cell.emotion = emotion(indexPath)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
    }
    
    private func emotion(indexPath:NSIndexPath)->Emotion{
        let package = Package.loadPakages()[indexPath.section]
        let emotion = package.emoticons![indexPath.item]
        return emotion
    }
    
}
