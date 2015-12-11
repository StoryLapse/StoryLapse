//
//  Comment.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/11/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import Foundation

struct Comment {
  var id: String
  var content: String
  var createdAt: NSDate
  var createdBy: User
  var photoId: String?
  var storyId: String
}