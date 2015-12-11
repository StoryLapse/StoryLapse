//
//  Story.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/10/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import Foundation

struct Story {
  
  enum RemindTypes {
    case Daily(hour: Int, minute: Int)
    case Weekly(weekday: Int, hour: Int, minute: Int)
    case Monthly(day: Int, hour: Int, minute: Int)
  }
  
  var title: String
  var description: String
  var photos: [Photo] = []
  var hashtags: [String] = []
  var remindType: RemindTypes? // It could be nil when user didn't set
  var createdAt: NSDate
  var updatedAt: NSDate
  var createdBy: User
}
