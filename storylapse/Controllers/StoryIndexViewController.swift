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
    
    title = "Stories"
    navigationController?.title = nil
    
    storyTableView.dataSource = self
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    stories = Story.getCurrentUserStories(getDatabase())
    storyTableView.reloadData()
  }
}

extension StoryIndexViewController: UITableViewDataSource {
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return stories.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = storyTableView.dequeueReusableCellWithIdentifier("storyTableViewCell") as! StoryTableViewCell
    
    cell.story = stories[indexPath.row]
    return cell
  }
}