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
  
  var id: String {
    get {
      return self.document!.documentID
    }
  }
  
  var localPath: String {
    get {
      return Photo.getPhotoDirURL()
        .URLByAppendingPathComponent(document!.documentID)
        .path! + ".jpg"
    }
  }
  
  override func willSave(changedPropertyNames: Set<NSObject>?) {
    self.type = Photo.type
  }
  
  static func create(db: CBLDatabase) -> Photo {
    let photo = Photo(forDocument: db.documentWithID(NSUUID().UUIDString.lowercaseString)!)
    
    photo.interactionCount = 0
    
    photo.creatorId = User.currentUser.id
    photo.createdAt = NSDate()
    
    return photo
  }
  
  static func getPhotoDirURL() -> NSURL {
    let rootDirURL = NSFileManager.defaultManager()
      .URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
    let photoDirURL = rootDirURL.URLByAppendingPathComponent("photos")
    
    return photoDirURL
  }
  
  func fileInDocumentsDirectory(filename: String) -> String {
    let fileURL = Photo.getPhotoDirURL().URLByAppendingPathComponent(filename)
    return fileURL.path!
  }
}

// MARK: Queries
extension Photo {
  static func getPhotos(db: CBLDatabase, story: Story) -> [Photo] {
    return story.photoIds.map { Photo(forDocument: db[$0]) }
  }
}
