//
//  MenuItem.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/22/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import Foundation

struct MenuViewItem {
  
  enum ItemType {
    case Normal
    case Cancel
  }
  
  typealias TapHandler = () -> Void
  
  var title: String? = nil
  var iconImage: UIImage? = nil
  var type: ItemType = .Normal
  var tapHandler: TapHandler?
  
  init(title: String?, iconImage: UIImage?, onTap tapHandler: TapHandler?) {
    self.title = title
    self.iconImage = iconImage
    self.tapHandler = tapHandler
  }
  
  init(title: String?, iconImage: UIImage?, type: ItemType) {
    self.title = title
    self.iconImage = iconImage
    self.type = type
  }
}