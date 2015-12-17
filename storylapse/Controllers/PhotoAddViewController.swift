//
//  PhotoAddViewController.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/15/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class PhotoAddViewController: UIViewController {
  
  @IBOutlet var imagePreviewView: UIImageView!
  @IBOutlet var tableView: UITableView!
  @IBOutlet var addPhotoToLabel: UILabel!

  var image: UIImage?
  var story: Story?
  var stories: [Story]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.hidden = false
    title = "Add new photo"
    
    if let validImage = self.image {
      self.imagePreviewView.image = validImage
    }
    
    addPhotoToLabel.textColor = Colors.primaryTextColor
    
    stories = Story.getCurrentUserStories(getDatabase())
    tableView.delegate = self
    tableView.dataSource = self
  }
}

// MARK: Stories TableView
extension PhotoAddViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return stories.count + 1
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    if indexPath.row > 0 {
      let cell = tableView.dequeueReusableCellWithIdentifier("storyCell") as! RecentStoryTableViewCell
      cell.story = stories[indexPath.row - 1]
      return cell
      
    } else {
      return tableView.dequeueReusableCellWithIdentifier("addStoryCell")!
    }
  }
}