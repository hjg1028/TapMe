//
//  Created by nanami on 11/8/15.
//  Copyright © 2015 H2. All rights reserved.
//

import UIKit

class RecordModel: NSObject {
    
    var id: String
    var recordDuration: String
    var everyKickTime: [String]
    var passOrNot: Bool
    var score: Int
    
    //记录点击时的时间
    func recordTapTime() {
        let currentTime = NSDate()
        self.everyKickTime.append(stringFromDate(currentTime)!)
    }
    
    init(id:String, recordDuration: String, everyKickTime: [String], passOrNot: Bool, score: Int) {
        self.id = id
        self.recordDuration = recordDuration
        self.everyKickTime = everyKickTime
        self.passOrNot = passOrNot
        self.score = score
    }
    
}
