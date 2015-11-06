//
//  ViewController.swift
//  Tap Me
//
//  Created by nanami on 10/27/15.
//  Copyright © 2015 nanami. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timer10Btn: UIButton!
    @IBOutlet weak var timer30Btn: UIButton!
    @IBOutlet weak var timer60Btn: UIButton!
    @IBOutlet weak var tapButton: UIButton!
    
    var score: Int = 0
    var seconds: Int = 0
    var timer = NSTimer()
    var timeSetting: Int = 0
    var tapTime: [String] = []
    
    //计时初始化
    func startGame(setTime: Int) {
        score = 0
        tapTime = []
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
            //显示Alert
            let alert = UIAlertController(title: "Time is up!", message: "You scored \(score) points in \(timeSetting) seconds. \(tapFrecuency) ms per tap on average.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default, handler: {ACTION in self.startGame(self.timeSetting)}))
            presentViewController(alert, animated: true, completion: nil)
            
            //输出纪录的点击时间到控制台
            for n in 0...tapTime.count - 1 {
                print(tapTime[n])
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //绘制圆形按钮
        tapButton.layer.cornerRadius = 100
        tapButton.layer.masksToBounds = true
        
        //保持屏幕常亮
        UIApplication.sharedApplication().idleTimerDisabled = true
    }
    
    
    //点击Tap按钮时
    @IBAction func buttonTapped(sender: AnyObject) {
        
        if seconds > 0 {
            score++
            recordTapTime()
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
    
    //记录每次点击的时间
    func recordTapTime() {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        tapTime.append(formatter.stringFromDate(NSDate()))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

