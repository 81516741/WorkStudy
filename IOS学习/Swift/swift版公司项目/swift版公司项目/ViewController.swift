//
//  ViewController.swift
//  swift版公司项目
//
//  Created by yh on 16/7/1.
//  Copyright © 2016年 ld. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tempFun:AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let a  = MyCell.text
        a("你妹")
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10;
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = MyCell.cell()
        return cell
    }
}

class MyCell: UITableViewCell {
    
   class func cell() -> MyCell {
        return NSBundle.mainBundle().loadNibNamed("MyCell", owner: nil, options: nil).last as! MyCell
    }
    
   class func text(s:String) -> Void {
        print(s)
    }
}

