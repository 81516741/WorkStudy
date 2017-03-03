//
//  ViewController.swift
//  swift创建collectionView
//
//  Created by yh on 16/6/8.
//  Copyright © 2016年 ld. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var jump: UIButton!

    @IBAction func Jumpto(sender: UIButton) {
        let vc = MyVC()
        vc.block = {(index:NSIndexPath)->() in
            print("你的屁屁漏出来了")
            print(index)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController:MyVCProtocol
{
    func click(index:NSIndexPath) {
        print("他奶奶的")
        print(index)
    }
}

