//
//  ViewController.swift
//  倒计时练习
//
//  Created by yh on 16/7/12.
//  Copyright © 2016年 ld. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicke: UIDatePicker!
    @IBOutlet weak var resultLable: UILabel!
    var timer:NSTimer?
    var cell:TableViewCell?
    
    @IBAction func tap(sender: AnyObject) {
        let date = datePicke.date
        let 时间差 = timeIntervalSinceNow(date)
        let formater = NSDateFormatter()
        formater.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        let desDateString = formater.stringFromDate(date)
        print(desDateString)
        resultLable.text = 时间差 as String
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let local = NSLocale.init(localeIdentifier: "zh_CN")
        datePicke.locale = local
        datePicke.datePickerMode = UIDatePickerMode.DateAndTime
        
        
    
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
//        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
//        
    }
    
    func timeIntervalSinceNow(date:NSDate)->NSString
    {
        let nowDate = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let compo =
        calendar.components([.Year,.Month,.Day,.Hour,.Minute,.Second], fromDate: nowDate, toDate: date, options: NSCalendarOptions.WrapComponents)
           
        return "\(compo.year)年\(compo.month)月\(compo.day)天 \(compo.hour)小时\(compo.minute)分\(compo.second)秒"
    }

}



