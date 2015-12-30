//
//  User.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/11/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import Foundation
import OAuthSwift
import Alamofire

class User: CBLModel {
  
  static let type = "User"
  
  @NSManaged var name: String
  @NSManaged var avatarPath: String
  @NSManaged var email: String
  
  var id: String {
    get {
      return self.document!.documentID
    }
  }
  
  static var currentUser: User! = nil
  static func initializeCurrentUser(db: CBLDatabase) {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    if let userId = userDefaults.stringForKey("currentUserId") {
      User.currentUser = User(forDocument: db.documentWithID(userId)!)
      User.currentUser.name = userDefaults.stringForKey("currentUserName")!
      User.currentUser.avatarPath = userDefaults.stringForKey("currentUserAvatarPath")!
      User.currentUser.email = userDefaults.stringForKey("currentUserEmail")!
      
      try! User.currentUser.save()
      
    } else {
      let userId = NSUUID().UUIDString.lowercaseString
      
      User.currentUser = User(forDocument: db.documentWithID(userId)!)
      User.currentUser.name = "You"
      User.currentUser.avatarPath = "https://upload.wikimedia.org/wikipedia/commons/7/7c/Profile_avatar_placeholder_large.png"
      
      try! User.currentUser.save()
    }
  }
  
  override func willSave(changedPropertyNames: Set<NSObject>?) {
    self.type = User.type
  }
}

extension User {
  
  static func loginFacebook(db: CBLDatabase, callback: (User) -> Void) {
    let oauthswift = OAuth2Swift(
      consumerKey:    "723451617791401",
      consumerSecret: "cab74919e00bdca0e7f4657330c4d055",
      authorizeUrl:   "https://www.facebook.com/dialog/oauth",
      accessTokenUrl: "https://graph.facebook.com/oauth/access_token",
      responseType:   "code"
    )
    let state: String = generateStateWithLength(20) as String
    
    oauthswift.authorizeWithCallbackURL(
      NSURL(string: "http://localhost:2292/api/v1/login/facebook/callback")!,
      scope: "public_profile,email",
      state: state,
      
      success: { credential, response, parameters in
        oauthswift.client.get(
          "https://graph.facebook.com/me?fields=id,name,email",
          
          success: { data, response in
            let userDefaults = NSUserDefaults.standardUserDefaults()
            var dataJSON = try! NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String : AnyObject]
            
            dataJSON["access_token"] = parameters["access_token"]
            dataJSON["expires"] = parameters["expires"]
            
            userDefaults.setValue(dataJSON["name"], forKey: "currentUserName")
            userDefaults.setValue(dataJSON["email"], forKey: "currentUserEmail")
            userDefaults.setValue(
              "http://graph.facebook.com/\(dataJSON["id"] as! String)/picture?type=square", forKey: "currentUserAvatarPath")
            userDefaults.setValue(User.currentUser.id, forKey: "currentUserId")
            
            User.initializeCurrentUser(db)
            callback(User.currentUser)
          },
          
          failure: { error in
            print(error)
        })
        
      },
      
      failure: { error in
        print(error.localizedDescription, terminator: "")
    })
  }
  
  static func logout(db: CBLDatabase, callback: () -> Void) {
    let userDefaults = NSUserDefaults.standardUserDefaults()
    ["currentUserId", "currentUserName", "currentUserEmail"].forEach { key in
      userDefaults.setNilValueForKey(key)
    }
    
    User.initializeCurrentUser(db)
  }
}