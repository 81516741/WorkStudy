//
//  HomeVC.swift
//  weibo_swift
//
//  Created by yh on 16/4/13.
//  Copyright © 2016年 yh. All rights reserved.
//

import UIKit

class HomeVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
    unLoginView.setUnLoginView("visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜", isHome: true)
        initNavi()
    }
    
    func initNavi(){
        //设置左右的btn
        navigationItem.leftBarButtonItem = UIBarButtonItem.creatBarButtonItem("navigationbar_friendattention", target: self, selector: #selector(HomeVC.leftBtnClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem.creatBarButtonItem("navigationbar_pop", target: self, selector: #selector(HomeVC.rightBtnClick))
        //设置中间的titleView
        let titleBtn = TitleBtn()
        titleBtn.setTitle("lingda ", forState: .Normal)
        titleBtn.addTarget(self, action: #selector(HomeVC.titleBtnClick(_:)), forControlEvents: .TouchUpInside)
        navigationItem.titleView = titleBtn
    }
    func titleBtnClick(titleBtn:TitleBtn){
        print("titleBtnClick")
        titleBtn.selected = !titleBtn.selected
        let sb = UIStoryboard.init(name: "PopSB", bundle: nil)
        let sbVC = sb.instantiateInitialViewController()
        sbVC?.transitioningDelegate = self
        sbVC?.modalPresentationStyle = .Custom
        self.presentViewController(sbVC!, animated: true, completion: nil)
    }
    
    func leftBtnClick() {
        print("leftBtnClick")
    }
    func rightBtnClick() {
        print("rightBtnClick")
    }
    
}

extension HomeVC:UIViewControllerTransitioningDelegate
{
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return PresentaionC(presentedViewController: presented, presentingViewController: presenting)
    }
}
