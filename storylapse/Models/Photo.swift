//
//  Photo.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/10/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import Foundation

class Photo: CBLModel {
  static let type = "Photo"
  
  @NSManaged var caption: String?
  @NSManaged var interactionCount: Int
  
  @NSManaged var storyId: String
  
  @NSManaged var createdAt: NSDate
  @NSManaged var creatorId: String
  
  override func willSave(changedPropertyNames: Set<NSObject>?) {
    self.type = Photo.type
  }
  
  static func create(db: CBLDatabase) -> Photo {
    let photo = Photo(forDocument: db.documentWithID(NSUUID().UUIDString)!)
    
    photo.interactionCount = 0
    
    photo.creatorId = User.currentUserId
    photo.createdAt = NSDate()
    
    return photo
  }
}
