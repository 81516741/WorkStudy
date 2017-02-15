//
//  ViewController.swift
//  SuperNotes
//
//  Created by ld on 16/7/16.
//  Copyright © 2016年 ld. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    lazy var dataList:[String]={
        let arr = ["百度地图"]
        return arr
    }();
}

extension ViewController:UITableViewDataSource,UITableViewDelegate
{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        cell?.textLabel?.text = dataList[indexPath.row]
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        switch indexPath.row {
        case 0:
        navigationController?.pushViewController(BaiDuMapVC(), animated: true)
        default:
            break
        }
    }
}