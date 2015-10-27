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
    
    var score: Int = 0
    var seconds: Int = 0
    var timer = NSTimer()
    
    func setupGame() {
        seconds = 10
        score = 0
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
            alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default, handler: {ACTION in self.setupGame()}))
            presentViewController(alert, animated: true, completion: nil)
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupGame()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonTapped(sender: AnyObject) {
        
        if seconds != 0 {
            score++
        }
        
        scoreLabel.text = "\(score)"
        
    }

}

