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
  @IBOutlet var captionTextField: UITextView!
  @IBOutlet var tableView: UITableView!
  @IBOutlet var createButton: UIButton!

  var image: UIImage?
  var story: Story?
  var stories: [Story]!
  var selectedIndex: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.hidden = false
    title = "Add new photo"
    
    if let validImage = self.image {
      self.imagePreviewView.image = validImage
    }
    
    stories = Story.getCurrentUserStories(getDatabase())
    
    tableView.delegate = self
    tableView.dataSource = self
    
    createButton.backgroundColor = Colors.tintColor
    createButton.tintColor = UIColor.whiteColor()
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    if story != nil {
      selectedIndex = stories.indexOf { $0.document?.documentID == story?.document?.documentID }
    }
  }
  
  @IBAction func handleCreateButtonTap(sender: UIButton) {
    if selectedIndex == nil {
      print("User haven't chosen story yet")
      // TODO: Alert view
      return
    }
    
    if captionTextField.text! == "" {
      // TODO: Alert view - Are you missing something?
      // return
    }
    
    let photo = Photo.create(getDatabase())
    let story = stories[selectedIndex!]
    
    photo.caption = captionTextField.text
    photo.storyId = story.document!.documentID
    
    story.photoIds += [photo.document!.documentID]
    
    try! photo.save()
    try! story.save()
    
    UIImageJPEGRepresentation(image!, 1)!
      .writeToFile(photo.localPath, atomically: true)

    navigationController?.dismissViewControllerAnimated(true, completion: nil)
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
      cell.selected = indexPath.row - 1 == selectedIndex
      cell.story = stories[indexPath.row - 1]
      return cell
      
    } else {
      return tableView.dequeueReusableCellWithIdentifier("addStoryCell")!
    }
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    selectedIndex = max(indexPath.row - 1, 0)
    tableView.reloadData()
  }
}