//
//  RemindNotification.swift
//  storylapse
//
//  Created by Khuong Pham on 12/22/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import Foundation
import UIKit

class RemindNotification {

  var timerNotification = NSTimer()

  func notification(story: Story) {
    let timeInterval = NSTimeInterval(story.remindeAtHour * 3600 + story.remindeAtMinute * 60)
    let notification = UILocalNotification()
    
    notification.alertAction = "Title"
    notification.alertBody = "It's time to take a photo"
    notification.fireDate = NSDate(timeIntervalSinceNow: timeInterval)
    
    for index in story.remindeAtDaysOfWeek {
//      let dayChoosen = 
    }
    
    notification.repeatCalendar = .None
    UIApplication.sharedApplication().scheduleLocalNotification(notification)
    timerNotification.invalidate()
  }
}


