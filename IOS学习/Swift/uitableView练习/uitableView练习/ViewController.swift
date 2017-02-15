//
//  ViewController.swift
//  uitableView练习
//
//  Created by yh on 16/4/1.
//  Copyright © 2016年 yh. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    lazy var dataList:[String] = {
        return ["niaho","nizaima","good","laia","laalal","kaixin"]
    }()
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if  cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
        }
        cell!.textLabel?.text = dataList[indexPath.row]
        return cell!
    }
}

