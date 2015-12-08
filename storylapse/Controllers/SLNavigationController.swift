//
//  SLNavigationController.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/8/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class SLNavigationController: UINavigationController {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    navigationBar.backgroundColor = UIColor.redColor()
  }
}