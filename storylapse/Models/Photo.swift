//
//  Photo.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/10/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import Foundation

struct Photo {
  var caption: String? = nil
  var remoteURLStr: String? = nil
  var interactionCount: Int = 0
  var createdAt: NSDate
  var createdBy: User
}
