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
    
    func startGame() {
        score = 0
        timeLabel.text = "\(seconds)"
        scoreLabel.text = "\(score)"
        timeLabel.textColor = UIColor.whiteColor()
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
        seconds = 30
        timer30Btn.selected = true
        startGame()
        
    }
    
    @IBAction func buttonTapped(sender: AnyObject) {
        
        if startAndTapBtn.titleLabel == "START" {
            startAndTapBtn.setTitle("TAP", forState: UIControlState.Normal)
        }
        
        if seconds > 0 {
            score++
            scoreLabel.text = "\(score)"
        }
        
    }
    
    @IBAction func timer10BtnTapped(sender: AnyObject) {
        resetButton()
        timer10Btn.selected = true
        seconds = 10
        startGame()
    }
    
    @IBAction func timer30BtnTapped(sender: AnyObject) {
        resetButton()
        timer30Btn.selected = true
        seconds = 30
        startGame()
    }
    
    @IBAction func timer60BtnTapped(sender: AnyObject) {
        resetButton()
        timer60Btn.selected = true
        seconds = 60
        startGame()
    }
    
    func resetButton() {
        timer10Btn.selected = false
        timer30Btn.selected = false
        timer60Btn.selected = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

