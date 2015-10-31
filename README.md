# TapMe
A simple app shows how fast you can tap the screen.

### Screenshot
![image](https://raw.githubusercontent.com/hjg1028/TapMe/master/Screen%20Shot.png "Screenshot")

### Code
```
import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timer10Btn: UIButton!
    @IBOutlet weak var timer30Btn: UIButton!
    @IBOutlet weak var timer60Btn: UIButton!
    
    var score: Int = 0
    var seconds: Int = 0
    var timer = NSTimer()
    var timeSetting: Int = 0
    
    func startGame(setTime: Int) {
        score = 0
        seconds = setTime
        timeLabel.text = "\(seconds)"
        scoreLabel.text = "\(score)"
        timeLabel.textColor = UIColor.whiteColor()
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("subtractTime"), userInfo: nil, repeats: true)
    }
    
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
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func buttonTapped(sender: AnyObject) {
        
        if seconds > 0 {
            score++
            scoreLabel.text = "\(score)"
        }
        
    }
    
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
