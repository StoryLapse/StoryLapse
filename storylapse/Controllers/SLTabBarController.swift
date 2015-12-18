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
  var hidden: Bool = false
  
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
    cameraButton.backgroundColor = Colors.tintColor
    cameraButton.addTarget(self, action: "handleCameraButtonTap:", forControlEvents: .TouchUpInside)
    
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
  
  func toggleTabBar(animated animated: Bool, showed: Bool? = nil) {
    let hidden = !(showed ?? self.hidden)
    
    if hidden == self.hidden {
      return
    }
    
    tabBar.hidden = false
    cameraButton.hidden = false
    
    self.hidden = hidden
    
    func animations() {
      let intensive = self.tabBar.frame.height * (hidden ? 1 : -1)
      
      self.tabBar.frame = CGRectOffset(self.tabBar.frame, 0, intensive)
      self.cameraButton.frame.origin.y += intensive
    }
    
    func completion(finish: Bool) {
      self.tabBar.hidden = hidden
      self.cameraButton.hidden = hidden
    }
    
    if (!animated) {
      animations()
      return completion(true)
    }
    
    UIView.animateWithDuration(0.3, animations: animations, completion: completion)
  }
  
  func handleCameraButtonTap(sender: UIButton!) {
    if let navViewController = viewControllers?[selectedIndex] as? SLNavigationController {
      navViewController.handleCameraButtonTap(sender)
    }
  }
}
