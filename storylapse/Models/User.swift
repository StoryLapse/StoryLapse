//
//  User.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/11/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import Foundation

class User: CBLModel {
  
  static let type = "User"
  
  @NSManaged var username: String
  @NSManaged var email: String
  
  static let currentUserId = "really-unique-user-id"
  
  override func willSave(changedPropertyNames: Set<NSObject>?) {
    self.type = User.type
  }
}