//
//  TableViewCell.swift
//  时间计算器
//
//  Created by yh on 16/7/12.
//  Copyright © 2016年 ld. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = UIColor.clearColor()
        contentView.backgroundColor = UIColor.clearColor()
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
