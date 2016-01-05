//
//  SLTabBarController.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/8/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class SLTabBarController: UITabBarController, BWWalkthroughViewControllerDelegate {
  
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
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    if !userDefaults.boolForKey("walkthroughPresented") {
      
      showWalkthrough()
      
      userDefaults.setBool(true, forKey: "walkthroughPresented")
      userDefaults.synchronize()
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  @IBAction func showWalkthrough() {
    
    // Get view controllers and build the walkthrough
    let stb = UIStoryboard(name: "Walkthrough", bundle: nil)
    let walkthrough = stb.instantiateViewControllerWithIdentifier("walk") as! BWWalkthroughViewController
    let page_zero = stb.instantiateViewControllerWithIdentifier("walk0")
    let page_one = stb.instantiateViewControllerWithIdentifier("walk1")
    let page_two = stb.instantiateViewControllerWithIdentifier("walk2")
    let page_three = stb.instantiateViewControllerWithIdentifier("walk3")
    
    // Attach the pages to the master
    walkthrough.delegate = self
    walkthrough.addViewController(page_one)
    walkthrough.addViewController(page_two)
    walkthrough.addViewController(page_three)
    walkthrough.addViewController(page_zero)
    
    self.presentViewController(walkthrough, animated: true, completion: nil)
  }
  
  
  // MARK: - Walkthrough delegate -
  
  func walkthroughPageDidChange(pageNumber: Int) {
    print("Current Page \(pageNumber)")
  }
  
  func walkthroughCloseButtonPressed() {
    dismissViewControllerAnimated(true, completion: nil)
  }

}
