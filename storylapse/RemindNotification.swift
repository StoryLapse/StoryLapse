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
    let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
    let date = NSDate()

    let dateComponents = calendar!.components([NSCalendarUnit.Day, NSCalendarUnit.WeekOfMonth, NSCalendarUnit.Month,NSCalendarUnit.Year,NSCalendarUnit.Hour,NSCalendarUnit.Minute], fromDate:date)
    dateComponents.hour = story.remindeAtHour
    dateComponents.minute = story.remindeAtMinute
    for index in 0..<story.remindeAtDaysOfWeek.count {
      if story.remindeAtDaysOfWeek[index] == true {
        if index != 6{
          dateComponents.weekday = index + 2
          fireNotification(calendar!, dateComponents: dateComponents)
        } else {
          dateComponents.weekday = 1
          fireNotification(calendar!, dateComponents: dateComponents)
        }
      } else {
        dateComponents.weekday = 0
      }
    }
  }

  func fireNotification(calendar: NSCalendar, dateComponents: NSDateComponents) {
    let notification = UILocalNotification()
    notification.alertAction = "Title"
    notification.alertBody = "It's time to take a photo"
    notification.repeatInterval = NSCalendarUnit.WeekOfYear
    notification.fireDate = calendar.dateFromComponents(dateComponents)
    UIApplication.sharedApplication().scheduleLocalNotification(notification)
  }
}


