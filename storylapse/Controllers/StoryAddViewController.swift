//
//  StoryAddViewController.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/18/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class StoryAddViewController: UIViewController {
  
  @IBOutlet var titleTextField: TextField!
  @IBOutlet var hashtagsTextField: TextField!
  @IBOutlet var createButton: UIButton!
  
  var story: Story?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Add new story"
    view.backgroundColor = Colors.primaryBackgroundColor
    (tabBarController as! SLTabBarController).toggleTabBar(animated: false, showed: false)
    
    createButton.backgroundColor = Colors.tintColor
    createButton.tintColor = UIColor.whiteColor()
  }
  
  override func viewWillAppear(animated: Bool) {
    if story == nil {
      story = Story.create(getDatabase())
    }
    
    titleTextField.text = story?.title
    hashtagsTextField.text = story?.hashtags.joinWithSeparator(", ")
    super.viewWillAppear(animated)
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    (tabBarController as! SLTabBarController).toggleTabBar(animated: true, showed: true)
  }
  
  @IBAction func handleViewTap(sender: AnyObject) {
    view.endEditing(true)
  }
  
  @IBAction func handleCreateButtonTap(sender: UIButton) {
    story?.title = titleTextField.text!
    story?.hashtags = hashtagsTextField.text!.split("\\s*,\\s*")
    
    try! story?.save()
    navigationController?.popViewControllerAnimated(true)
  }
}
