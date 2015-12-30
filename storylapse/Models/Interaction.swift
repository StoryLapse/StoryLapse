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
    case Kiss
    case ThumbUp
    case Gorgeous
    case Heart
  }
  
  var type: Type
  
  init(type: Type) {
    self.type = type
  }
}