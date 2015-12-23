//
//  StoryTableViewCell.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/13/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class StoryTableViewCell: UITableViewCell {
  
  @IBOutlet var cardView: UIView!
  @IBOutlet var topView: UIView!
  @IBOutlet var userAvatarImageView: UIImageView!
  @IBOutlet var usernameLabel: UILabel!
  @IBOutlet var updateMomentLabel: UILabel!
  @IBOutlet var interactionCountButton: UIButton! {
    didSet {
      let interactionImage = UIImage(named: "star-icon")?.imageWithRenderingMode(.AlwaysTemplate)
      interactionCountButton.tintColor = Colors.secondaryTextColor
      interactionCountButton.setImage(interactionImage, forState: .Normal)
      interactionCountButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5)

      let titleLabel = interactionCountButton.titleLabel!
      let imageView = interactionCountButton.imageView!
      
      interactionCountButton.transform = CGAffineTransformScale(interactionCountButton.transform, -1, 1)
      titleLabel.transform = CGAffineTransformScale(titleLabel.transform, -1, 1)
      imageView.transform = CGAffineTransformScale(imageView.transform, -1, 1)

    }
  }
  @IBOutlet var photoPlayView: StoryPhotoPlayView!
  @IBOutlet var primaryInteractButton: InteractButton!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var photoCountLabel: UILabel!
  @IBOutlet var addPhotoButton: UIButton!
  var delegate: StoryTableViewCellDelegate?

  var photos: [Photo] = []
  var story: Story! {
    didSet {
      titleLabel.text = story.title
      photoCountLabel.text = String(format: "%d photos", arguments: [story.photoCount])
      
      photos = Photo.getPhotos(getDatabase(), story: story)
      photoPlayView.story = story
      photoPlayView.play()
    }
  }
  
  override func awakeFromNib() {
    selectionStyle = .None
    backgroundColor = UIColor.clearColor()
    
    cardView.backgroundColor = Colors.canvasColor
    
    topView.backgroundColor = UIColor.clearColor()
    userAvatarImageView.backgroundColor = UIColor.darkGrayColor()
    usernameLabel.textColor = Colors.primaryTextColor
    updateMomentLabel.textColor = Colors.secondaryTextColor
    
    photoPlayView.contentMode = .Center
    titleLabel.textColor = Colors.primaryTextColor
    photoCountLabel.textColor = Colors.secondaryTextColor
    photoPlayView.backgroundColor = UIColor.darkGrayColor()
    
    // Interact buttons
    primaryInteractButton.addTarget(target: self, action: "handleInteraction:")
    
    // Change colors
    addPhotoButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.10)
    addPhotoButton.setImage(UIImage(named: "camera-icon"), forState: .Normal)
    addPhotoButton.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8)
  }
  
  func handleInteraction(button: InteractButton) {
    switch (button) {
    case primaryInteractButton:
      addSubview(FloatBubble(frame: photoPlayView.frame, direction: .LeftToRight, intensive: CGFloat(50)))
      
      NSTimer.after(0.5) { () -> Void in
        self.addSubview(FloatBubble(frame: self.photoPlayView.frame, direction: .RightToLeft, intensive: CGFloat(50)))
      }
      break
      
    default:
      break
    }
  }
  
  @IBAction func handleAddPhotoButtonTap(sender: UIButton) {
    delegate?.storyCell?(didTapAddPhotoButtonForStory: story)
  }
}

@objc protocol StoryTableViewCellDelegate {
  optional func storyCell(didTapAddPhotoButtonForStory story: Story)
}