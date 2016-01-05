//
//  StoryIndexViewController.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/8/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class StoryIndexViewController: UIViewController {
  
  @IBOutlet var noStoryIndicatorView: UIView!
  @IBOutlet var storyTableView: UITableView!
  
  var stories: [Story]!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    storyTableView.dataSource = self
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    title = "Stories"
    stories = Story.getCurrentUserStories(getDatabase())
    dispatch_async(dispatch_get_main_queue()) {
      self.storyTableView.reloadData()
    }
  }
}

// MARK: TableView
extension StoryIndexViewController: UITableViewDataSource, StoryTableViewCellDelegate {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return stories.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = storyTableView.dequeueReusableCellWithIdentifier("storyTableViewCell") as! StoryTableViewCell
    
    cell.story = stories[indexPath.row]
    cell.delegate = self
    return cell
  }
  
  func storyCell(didTapAddPhotoButtonForStory story: Story) {
    performSegueWithIdentifier("takePhotoSegue", sender: story)
  }
}

// MARK: Navigations
extension StoryIndexViewController {
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showStorySegue" {
      let storyViewController = segue.destinationViewController as! SLStoryViewController
      let story = (sender as! StoryTableViewCell).story
      
      title = ""
      storyViewController.story = story
    }
    
    if segue.identifier == "takePhotoSegue" {
      let cameraViewController = (segue.destinationViewController as! SLNavigationController).topViewController as! CameraViewController
      let story = sender as! Story
      
      cameraViewController.story = story
    }
  }
  
  @IBAction func handleLoginButtonTap(sender: AnyObject) {
    let loginViewController = storyboard!.instantiateViewControllerWithIdentifier("loginViewController")
    presentViewController(loginViewController, animated: true, completion: nil)
  }
}