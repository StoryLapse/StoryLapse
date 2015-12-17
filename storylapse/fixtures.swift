//
//  fixtures.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/12/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

func resetFixtures() {
  try! CBLManager.sharedInstance().databaseNamed("storylapse").deleteDatabase()
  let db = try! CBLManager.sharedInstance().databaseNamed("storylapse")
  
  // Create stories
  [String](["My sweetheart!", "The Dalat trip"]).forEach { title in
    let story = Story.create(db)
    story.title = title
    try! story.save()
  }
  
  // Create photos
  let results = try! db.createAllDocumentsQuery().run()
  let samplePhotoDirURL = NSFileManager.defaultManager()
    .URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
    .URLByAppendingPathComponent("sample-photos")
  
  print("Please unzip sample-photos into \(samplePhotoDirURL)")
  
  while let row = results.nextRow() {
    let story = Story(forDocument: row.document!)
    
    for idx in 1...40 {
      let photo = Photo.create(db)
      photo.storyId = story.document!.documentID
      
      try! photo.save()
      story.photoIds += [photo.document!.documentID]
      
      // Copy images
        
      let samplePhotoPath = samplePhotoDirURL.URLByAppendingPathComponent(String(format: "sample-%d.jpg", idx % 5)).path!
      
      try! NSFileManager.defaultManager().copyItemAtPath(samplePhotoPath, toPath: photo.localPath)

    }
    
    try! story.save()
  }
}