//
//  MyVC.swift
//  swift创建collectionView
//
//  Created by yh on 16/6/8.
//  Copyright © 2016年 ld. All rights reserved.
//

import UIKit

protocol MyVCProtocol {
    func click(index:NSIndexPath)
}


class MyVC: UIViewController {

    var block:((index:NSIndexPath)->())?
    var dele:MyVCProtocol?
    @IBOutlet weak var col: UICollectionView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        col.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        // Do any additional setup after loading the view.
    }
}

extension MyVC:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
        if (indexPath.row % 2) == 0 {
            cell.backgroundColor = UIColor.greenColor()
        }else{
            
            cell.backgroundColor = UIColor.orangeColor()
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        dele?.click(indexPath)
        block!(index: indexPath)
    }
}

class MyLayout: UICollectionViewFlowLayout {
    override func prepareLayout() {
        super.prepareLayout()
        itemSize = CGSizeMake(UIScreen.mainScreen().bounds.width, 44)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
    }
}
