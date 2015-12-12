//
//  Interaction.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/11/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import Foundation

struct Interaction {
  
  enum Type {
    case SimpleSmile
    case ThumbUp
    case HeartEyes
  }
  
  var id: String
  var type: Type
  var createdAt: NSDate
  var createdBy: User
  var photoId: String?
  var storyId: String
}