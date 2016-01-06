//
//  SLStoryViewController.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 1/3/16.
//  Copyright © 2016 Lê Quang Bửu. All rights reserved.
//

import UIKit
import Cartography

class SLStoryViewController: UIViewController {
  
  var photos: [Photo] = []
  var story: Story! {
    didSet {
      photos = Photo.getPhotos(getDatabase(), story: story)
      title = story.title
    }
  }
  
  @IBOutlet var tableView: StoryTableView!
  
  @IBOutlet var interactionCountButton: UIButton!
  @IBOutlet var interactButton1: InteractButton! {
    didSet {
      interactButton1.interaction = Interaction(type: .ThumbUp)
    }
  }
  @IBOutlet var interactButton2: InteractButton! {
    didSet {
      interactButton2.interaction = Interaction(type: .Heart)
    }
  }
  @IBOutlet var interactButton3: InteractButton! {
    didSet {
      interactButton3.interaction = Interaction(type: .Gorgeous)
    }
  }
  @IBOutlet var interactButton4: InteractButton! {
    didSet {
      interactButton4.interaction = Interaction(type: .Kiss)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.allowsSelection = false
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 100
    tableView.dataSource = self
    
    tableView.backgroundColor = Colors.secondaryBackgroundColor
    
    // Interact buttons
    [interactButton1, interactButton2, interactButton3, interactButton4].forEach { button in
      button.addTarget(target: self, action: "handleInteraction:")
    }
    
    interactionCountButton.tintColor = Colors.primaryTextColor
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    if story != nil {
      story = Story(forDocument: getDatabase().documentWithID(story.document!.documentID)!)
    }
    
    tableView.reloadData()
  }
  
  @IBAction func handleMenuButtonTap(sender: UIBarButtonItem) {
    let menuViewController = MenuViewController(items:
      [
        MenuViewItem(title: "Report", iconImage: UIImage(named: "warning-menu-icon")) {
          print("Reported")
        },
        MenuViewItem(title: "Delete", iconImage: UIImage(named: "garbage-bin-menu-icon")) {
          print("Deleted")
        },
        MenuViewItem(title: "Cancel", iconImage: UIImage(named: "cross-menu-icon"), type: .Cancel)
      ]
    )
    
    presentViewController(menuViewController, animated: true, completion: nil)
  }
  
  @IBAction func handlePlayButtonTap(sender: UIBarButtonItem) {
    performSegueWithIdentifier("playStorySegue", sender: nil)
  }
  
  
  func handleInteraction(button: InteractButton) {
    view.addSubview(
      FloatBubble(
        frame: view.frame,
        interaction: button.interaction,
        direction: .LeftToRight,
        intensive: CGFloat(50)
      )
    )
    
    NSTimer.after(0.5) { () -> Void in
      let interaction = [
        Interaction(type: .ThumbUp),
        Interaction(type: .Heart),
        Interaction(type: .Gorgeous),
        Interaction(type: .Kiss)
        ][Int(arc4random_uniform(4))]
      
      self.view.addSubview(
        FloatBubble(
          frame: self.view.frame,
          interaction: interaction,
          direction: .RightToLeft,
          intensive: CGFloat(50)
        )
      )
    }
  }
}

extension SLStoryViewController: UITableViewDataSource {
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1
      
    case 1:
      return (story.photoCount + 2) / 3
      
    case 2:
      return 1
      
    default:
      assert(false, "Section not implemented")
    }
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    switch indexPath.section {
    case 0:
      // Story info section
      let cell = tableView.dequeueReusableCellWithIdentifier("infoCell") as! SLStoryInfoCell
      
      cell.story = story
      return cell
      
    case 1:
      // Story photo section
      let cell = tableView.dequeueReusableCellWithIdentifier("photoRow") as! SLStoryPhotoRow
      let startIndex = indexPath.row * 3
      let endIndex = min(startIndex + 3, story.photoCount - 1)
      
      cell.photos = [Photo](photos[startIndex...endIndex])
      
      if cell.photoTargets.count == 0 {
        cell.addPhotoTarget(self, action: "handlePhotoTap:")
      }
      
      return cell
      
    default:
      return UITableViewCell()
    }
  }
  
  func handlePhotoTap(photo: Photo) {
    performSegueWithIdentifier("showPhotoDetailSegue", sender: photo)
  }
}

// MARK: Navigation
extension SLStoryViewController {
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showPhotoDetailSegue" {
      let photoIndex = photos.indexOf(sender as! Photo)!
      let photoDetailViewController = segue.destinationViewController as! PhotoDetailViewController
      
      photoDetailViewController.story = story
      photoDetailViewController.selectedPhotoIndex = photoIndex
    }
    
    if segue.identifier == "playStorySegue" {
      let playPhotosImageViewController = segue.destinationViewController as! PlayPhotosImageViewController
      
      playPhotosImageViewController.story = story
    }
  }
}

class SLStoryInfoCell: UITableViewCell {
  
  @IBOutlet var creatorAvatarImageView: UIImageView!
  @IBOutlet var creatorNameLabel: UILabel!
  @IBOutlet var updatedMomentLabel: UILabel!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var descriptionLabel: UILabel!
  
  var story: Story! {
    didSet {
      creatorAvatarImageView.af_setImageWithURL(NSURL(string: story.creatorAvatarPath)!)
      creatorAvatarImageView.layer.cornerRadius = 2
      creatorAvatarImageView.clipsToBounds = true
      
      creatorNameLabel.text = story.creatorName
      titleLabel.text = story.title
      updatedMomentLabel.text = story.updatedMoment
      descriptionLabel.text = story.desc
      
      descriptionLabel.hidden = descriptionLabel.text == ""
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    backgroundColor = Colors.canvasColor
    
    creatorNameLabel.textColor = Colors.primaryTextColor
    titleLabel.textColor = Colors.primaryTextColor
    updatedMomentLabel.textColor = Colors.primaryTextColor
    descriptionLabel.textColor = Colors.primaryTextColor
  }
}

class SLStoryPhotoRow: UITableViewCell {
  
  @IBOutlet private var photoImageView1: UIImageView!
  @IBOutlet private var photoImageView2: UIImageView!
  @IBOutlet private var photoImageView3: UIImageView!
  
  var photoImageViews: [UIImageView]! {
    get {
      return [photoImageView1, photoImageView2, photoImageView3]
    }
  }
  
  var photos: [Photo]! {
    didSet {
      photoImageViews.enumerate().forEach {
        if (photos.count <= $0.index) {
          $0.element.alpha = 0
          
        } else {
          $0.element.image = UIImage(named: photos[$0.index].localPath)
        }
      }
    }
  }

  var photoTargets: [(AnyObject, Selector)] = []
  
  override func awakeFromNib() {
    super.awakeFromNib()
    backgroundColor = UIColor.clearColor()
    
    photoImageViews.enumerate().forEach { index, imageView in
      let button = UIButton()
      
      contentView.addSubview(button)
      
      constrain(button, imageView) {button, imageView in
        button.top == imageView.top
        button.right == imageView.right
        button.bottom == imageView.bottom
        button.left == imageView.left
      }
      
      button.tag = index
      button.addTarget(self, action: "handlePhotoTap:", forControlEvents: .TouchUpInside)
    }
  }
  
  func handlePhotoTap(sender: UIButton) {
    if (sender.tag < photos.count) {
      let photo = photos[sender.tag]
      photoTargets.forEach { object, action in
        object.performSelector(action, withObject: photo)
      }
    }
  }
  
  func addPhotoTarget(object: AnyObject, action: Selector) {
    photoTargets += [(object, action)]
  }
}

class SLStoryStatsCell: UITableViewCell {
  
  @IBOutlet var interactionCountButton: UIButton!
  var story: Story! {
    didSet {
      interactionCountButton.setTitle(String(format: "%d INTERACTIONS", story.interactionCount), forState: .Normal)
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    backgroundColor = Colors.canvasColor
    interactionCountButton.tintColor = Colors.primaryTextColor
  }
}