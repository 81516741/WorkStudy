//
//  NewFeatureVC.swift
//  weibo_swift
//
//  Created by ld on 16/5/15.
//  Copyright © 2016年 yh. All rights reserved.
//

import UIKit

private let pageCount : NSInteger = 4
private let reuseID = "cell"
private let screenW = UIScreen.mainScreen().bounds.size.width
private let screenH = UIScreen.mainScreen().bounds.size.height
private let btnW : CGFloat = 180.0
private let btnH : CGFloat = 40.0

class NewFeatureVC: UICollectionViewController
{
    init()
    {
        super.init(collectionViewLayout: MyCollectionLayout())
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        collectionView?.registerClass(MyCollectionCell.self, forCellWithReuseIdentifier:reuseID)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return pageCount
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView .dequeueReusableCellWithReuseIdentifier(reuseID, forIndexPath: indexPath) as! MyCollectionCell
        cell.index = indexPath.item
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        let path = collectionView.indexPathsForVisibleItems().last
        if path?.item == pageCount - 1 {
            let cell = collectionView.cellForItemAtIndexPath(path!) as! MyCollectionCell
            cell.startAnimation()
        }
        
    }
    
    
}

private class MyCollectionCell: UICollectionViewCell
{
    var index:Int?
    {
        didSet{
            setUpUI()
            iconImageView.image = UIImage(named: "new_feature_\(index! + 1)")
        }
    }

    func startAnimation(){
        comeInBtn.transform = CGAffineTransformMakeScale(0, 0)
        comeInBtn.userInteractionEnabled = false
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.comeInBtn.transform = CGAffineTransformIdentity
            self.comeInBtn.userInteractionEnabled = true
            }, completion: { (isOK) in
                
        })
    }
    private func setUpUI()
    {
        contentView.addSubview(iconImageView)
        contentView.addSubview(comeInBtn)
        if index == pageCount - 1 {
            comeInBtn.hidden = false
        }else{
            comeInBtn.hidden = true
        }
    }
    
    private lazy var iconImageView:UIImageView = {
        let icon = UIImageView()
        icon.frame = UIScreen.mainScreen().bounds
        return icon
    }()
    
    private lazy var comeInBtn : UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "new_feature_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "new_feature_button_highlighted"), forState: UIControlState.Highlighted)
        btn.frame = CGRectMake((screenW - btnW) * 0.5,screenH - 100.0, btnW, btnH)
        btn.hidden = true
        return btn
    }()
    
}

private class MyCollectionLayout: UICollectionViewFlowLayout
{
    override func prepareLayout()
    {
        itemSize = UIScreen.mainScreen().bounds.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        scrollDirection = .Horizontal
        
        collectionView?.bounces = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.pagingEnabled = true
        
    }
}