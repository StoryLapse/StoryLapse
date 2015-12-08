//
//  SLTabBarController.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/8/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class SLTabBarController: UITabBarController {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    let storyIndexNavController = storyboard!.instantiateViewControllerWithIdentifier("storyIndexNavController")
    let storyIndexNavController2 = storyboard!.instantiateViewControllerWithIdentifier("storyIndexNavController")
    
    viewControllers = [storyIndexNavController, storyIndexNavController2]
  }
}
