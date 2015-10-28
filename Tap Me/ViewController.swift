//
//  ViewController.swift
//  Tap Me
//
//  Created by nanami on 10/27/15.
//  Copyright © 2015 nanami. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timer10Btn: UIButton!
    @IBOutlet weak var timer30Btn: UIButton!
    @IBOutlet weak var timer60Btn: UIButton!
    @IBOutlet weak var startAndTapBtn: UIButton!
    
    var score: Int = 0
    var seconds: Int = 0
    var timer = NSTimer()
    
    func resetButton() {
        timer10Btn.selected = false
        timer30Btn.selected = false
        timer60Btn.selected = false
    }
    
    func startGame() {
        timeLabel.text = "\(seconds)"
        timeLabel.textColor = UIColor.whiteColor()
        scoreLabel.text = "\(score)"
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("subtractTime"), userInfo: nil, repeats: true)
    }
    
    func subtractTime() {
        
        seconds--
        timeLabel.text = "\(seconds)"
        
        if seconds == 3 {
            
            timeLabel.textColor = UIColor.redColor()
            
        }
        
        if seconds == 0 {
            
            timer.invalidate()
            
            //显示Alert
            let alert = UIAlertController(title: "Time is up!", message: "You scored \(score) points", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default, handler: {ACTION in self.startGame()}))
            presentViewController(alert, animated: true, completion: nil)
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //default timer is 30
        startAndTapBtn.setTitle("START", forState: UIControlState.Normal)
        timer30Btn.selected = true
        seconds = 30
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonTapped(sender: AnyObject) {
        
        if startAndTapBtn.titleLabel == "START" {
            startGame()
        }
        
        startAndTapBtn.setTitle("TAP", forState: UIControlState.Normal)
        
        if seconds != 0 {
            score++
        }
        
        scoreLabel.text = "\(score)"
        
    }
    
    @IBAction func timer10BtnTapped(sender: AnyObject) {
        resetButton()
        timer10Btn.selected = true
        timeLabel.text = "10"
        seconds = 10
        score = 0
    }
    
    @IBAction func timer30BtnTapped(sender: AnyObject) {
        resetButton()
        timer30Btn.selected = true
        timeLabel.text = "30"
        seconds = 30
        score = 0
    }
    
    @IBAction func timer60BtnTapped(sender: AnyObject) {
        resetButton()
        timer60Btn.selected = true
        timeLabel.text = "60"
        seconds = 60
        score = 0
    }
    

}

