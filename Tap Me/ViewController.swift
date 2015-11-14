//
//  ViewController.swift
//  Tap Me
//
//  Created by nanami on 10/27/15.
//  Copyright © 2015 nanami. All rights reserved.
//

import UIKit
import Foundation

var records: [RecordModel] = []

//设置时间格式，并将NSDate转换成String
func stringFromDate(time: NSDate) -> String? {
    
    let formatter = NSDateFormatter()
    formatter.dateFormat = "HH:mm:ss"
    let timeString = formatter.stringFromDate(time)
    return timeString
    
}

class ViewController: UIViewController /*UITableViewDataSource*/ {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timer10Btn: UIButton!
    @IBOutlet weak var timer30Btn: UIButton!
    @IBOutlet weak var timer60Btn: UIButton!
    @IBOutlet weak var tapButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var score: Int = 0
    var seconds: Int = 0
    var timer = NSTimer()
    var timeSetting: Int = 0
    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //绘制圆形按钮
        tapButton.layer.cornerRadius = 100
        tapButton.layer.masksToBounds = true
        
        //手动添加3条数据
        records = [RecordModel(id: "1", recordDuration: "10s", everyKickTime: ["14:33:29", "14:33:31", "14:33:34", "14:33:42"], passOrNot: false, score: 4),
            RecordModel(id: "2", recordDuration: "30s", everyKickTime: ["14:33:29", "14:33:31", "14:33:34", "14:33:42", "14:33:42", "14:33:42"], passOrNot: false, score: 6),
            RecordModel(id: "3", recordDuration: "60s", everyKickTime: ["14:33:29", "14:33:31", "14:33:34", "14:33:42", "14:33:42", "14:33:42", "14:33:42", "14:33:42"], passOrNot: false, score: 8)]
    }
    
    //计时初始化
    func startGame(setTime: Int) {
        
        //记录开始后保持屏幕常亮
        UIApplication.sharedApplication().idleTimerDisabled = true
        
        score = 0
        seconds = setTime
        timeLabel.text = "\(seconds)"
        scoreLabel.text = "\(score)"
        timeLabel.textColor = UIColor.whiteColor()
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("subtractTime"), userInfo: nil, repeats: true)
        
    }
    
    //计时器及及时完成后弹出Alert
    func subtractTime() {
        
        seconds--
        timeLabel.text = "\(seconds)"
        
        let tapFrecuency = NSString(format: "%.2f", Double(timeSetting) / Double(score) * 1000)
        
        if seconds == 3 {
            timeLabel.textColor = UIColor.redColor()
        }
        
        if seconds == 0 {
            timer.invalidate()
            //计时为0时显示Alert
            let alert = UIAlertController(title: "Time is up!", message: "You scored \(score) points in \(timeSetting) seconds. \(tapFrecuency) ms per tap on average.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default, handler: {ACTION in self.startGame(self.timeSetting)}))
            presentViewController(alert, animated: true, completion: nil)
            
            //记录结束后关闭屏幕常亮
            UIApplication.sharedApplication().idleTimerDisabled = false
        }
        
    }
    

    
    
    //点击Kick按钮时
    @IBAction func buttonTapped(sender: AnyObject) {
        
        if seconds > 0 {
            score++
            scoreLabel.text = "\(score)"
        }
        
    }
    
    //选择时长并开始计时
    @IBAction func timer10BtnTapped(sender: AnyObject) {
        resetButtonsAndTimer()
        timer10Btn.selected = true
        timeSetting = 10
        startGame(timeSetting)
    }
    
    @IBAction func timer30BtnTapped(sender: AnyObject) {
        resetButtonsAndTimer()
        timer30Btn.selected = true
        timeSetting = 30
        startGame(timeSetting)
    }
    
    @IBAction func timer60BtnTapped(sender: AnyObject) {
        resetButtonsAndTimer()
        timer60Btn.selected = true
        timeSetting = 60
        startGame(timeSetting)
    }
    
    //清除时长按钮选择状态及timer归零
    func resetButtonsAndTimer() {
        timer10Btn.selected = false
        timer30Btn.selected = false
        timer60Btn.selected = false
        timer.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

