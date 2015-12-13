//
//  SLTabBarController.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/8/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class SLTabBarController: UITabBarController {
  
  var cameraButton = UIButton(type: .System)
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    tabBar.barTintColor = Colors.ebony
    tabBar.barStyle = .Black
    
    // Story index view controller
    let storyIndexNavController = storyboard!.instantiateViewControllerWithIdentifier("storyIndexNavController")
    let storyIndexTabBarItem = UITabBarItem(title: nil, image: UIImage(named: "person-icon"), tag: 0)
    
    storyIndexTabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    storyIndexNavController.tabBarItem = storyIndexTabBarItem
    
    // Content add view controller
    let contentAddViewController = storyboard!.instantiateViewControllerWithIdentifier("storyIndexNavController")
    
    cameraButton.setImage(UIImage(named: "camera-icon"), forState: .Normal)
    cameraButton.tintColor = UIColor.whiteColor()
    cameraButton.center = tabBar.center
    cameraButton.titleLabel?.text = "asd"
    cameraButton.backgroundColor = Colors.tintColor
    cameraButton.addTarget(self, action: "add:", forControlEvents: .TouchUpInside)
    
    view.addSubview(cameraButton)
    
    // Explore view controller
    let exploreViewController = storyboard!.instantiateViewControllerWithIdentifier("storyIndexNavController")
    let exploreTabBarItem = UITabBarItem(title: nil, image: UIImage(named: "compass-icon"), tag: 0)
    
    exploreTabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    exploreViewController.tabBarItem = exploreTabBarItem
    
    viewControllers = [storyIndexNavController, contentAddViewController, exploreViewController]
  }
  
  override func viewDidLoad() {
    cameraButton.frame = CGRectMake(0, 0, 100, tabBar.frame.height)
    cameraButton.center = tabBar.center
  }
  
  func add(sender: UIButton) {
    print(sender)
  }
}
