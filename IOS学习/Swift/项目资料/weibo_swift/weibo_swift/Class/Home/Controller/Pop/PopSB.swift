//
//  PopSB.swift
//  weibo_swift
//
//  Created by ld on 16/5/9.
//  Copyright © 2016年 yh. All rights reserved.
//

import UIKit

class PopSB: UIViewController {

    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

extension PopSB: UITableViewDelegate,UITableViewDataSource
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        if cell == nil {
            cell = UITableViewCell.init(style:.Default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = "(index.row)"
        return cell!
    }
}