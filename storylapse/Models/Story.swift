
//
//  Story.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/10/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import Foundation

class Story: CBLModel {
  
  static let type = "Story"
  
  @NSManaged var title: String
  @NSManaged var desc: String?
  @NSManaged var photoIds: [String]
  @NSManaged var hashtags: [String]
  @NSManaged var remindeAtHour: Int
  @NSManaged var remindeAtMinute: Int
  @NSManaged var remindeAtDaysOfWeek: [Bool]

  @NSManaged var interactionCount: Int
  @NSManaged var commentCount: Int
  
  @NSManaged var creatorId: String
  @NSManaged var creatorName: String
  @NSManaged var creatorAvatarPath: String

  @NSManaged var createdAt: NSDate
  @NSManaged var updatedAt: NSDate?
  
  var id: String {
    get {
      return self.document!.documentID
    }
  }
  
  var photoCount: Int {
    get {
      return photoIds.count
    }
  }
  
  static func create(db: CBLDatabase) -> Story {
    let story = Story(forDocument: db.documentWithID(NSUUID().UUIDString.lowercaseString)!)
    
    story.title = ""
    story.photoIds = []
    story.hashtags = []
    
    story.interactionCount = 0
    story.commentCount = 0
    
    story.creatorId = User.currentUser.id
    story.creatorName = User.currentUser.name
    story.creatorAvatarPath = User.currentUser.avatarPath
    story.createdAt = NSDate()
    
    return story
  }
  
  override func willSave(changedPropertyNames: Set<NSObject>?) {
    self.type = Story.type
  }
}

// MARK: Indexes
extension Story {
  static func createViews(db: CBLDatabase) {
    // currentUserStories view
    let currentUserStoriesView = db.viewNamed("currentUserStories")
    currentUserStoriesView.setMapBlock({ (doc, emit) -> Void in
      if let
        type = doc["type"] as? String,
        creatorId = doc["creatorId"] as? String where
        type == Story.type && creatorId == User.currentUser.id {
          emit(doc["createdAt"]!, doc)
      }
      }, version: "1")
  }
  
  static func updateCurrentUserStories(db: CBLDatabase) {
    Story.getCurrentUserStories(db).forEach { story in
      story.creatorName = User.currentUser.name
      story.creatorAvatarPath = User.currentUser.avatarPath
      
      try! story.save()
    }
  }
}

// MARK: Queries
extension Story {
  static func getCurrentUserStories(db: CBLDatabase) -> [Story] {
    let query = db.viewNamed("currentUserStories").createQuery()
    let results = try! query.run()
    let stories = results.map { Story(forDocument: $0.document!!) }
    
    return stories
  }
}