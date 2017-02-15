//
//  UnLoginView.swift
//  weibo_swift
//
//  Created by ld on 16/4/16.
//  Copyright © 2016年 yh. All rights reserved.
//

import UIKit

protocol UnLoginViewDelegate :NSObjectProtocol {
    func unLoginViewLoginBtnClick()
    func unLoginViewRegisterBtnClick()
}

class UnLoginView: UIView
{
    weak var delegate:UnLoginViewDelegate?
    @IBOutlet weak var rotateObject: UIImageView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var messageLable: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func unLoginView() -> UnLoginView {
        return NSBundle.mainBundle().loadNibNamed("UnloginView", owner: self, options: nil).last as! UnLoginView
    }
    
    func setUnLoginView(image:String,message:String,isHome:Bool)
    {
        rotateObject.hidden = !isHome
        iconImage.image = UIImage(named: image)
        messageLable.text = message
        addAnimation()
    }
    
    func addAnimation(){
        let anim = CABasicAnimation.init(keyPath: "transform.rotation")
        anim.repeatCount = MAXFLOAT
        anim.removedOnCompletion = false
        anim.toValue = 2 * M_PI
        anim.duration = 20.0
        rotateObject.layer.addAnimation(anim, forKey: "myKey")
    }
    @IBAction func loginClick(sender: AnyObject) {
        delegate?.unLoginViewLoginBtnClick()
    }
    
    @IBAction func registerClick(sender: AnyObject) {
        delegate?.unLoginViewRegisterBtnClick()
    }

}
