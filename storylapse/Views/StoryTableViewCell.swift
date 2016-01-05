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
  @IBOutlet var creatorAvatarImageView: UIImageView!
  @IBOutlet var creatorNameLabel: UILabel!
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
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var photoCountLabel: UILabel!
  @IBOutlet var addPhotoButton: UIButton!
  var delegate: StoryTableViewCellDelegate?
  
  var photos: [Photo] = []
  var story: Story! {
    didSet {
      creatorAvatarImageView.af_setImageWithURL(NSURL(string: story.creatorAvatarPath)!)
      creatorAvatarImageView.layer.cornerRadius = 2
      creatorAvatarImageView.clipsToBounds = true
      
      creatorNameLabel.text = story.creatorName
      titleLabel.text = story.title
      photoCountLabel.text = String(format: "%d photos", arguments: [story.photoCount])
      interactionCountButton.setTitle(String(format: "%d", story.interactionCount), forState: .Normal)
      
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
    creatorAvatarImageView.backgroundColor = UIColor.darkGrayColor()
    creatorNameLabel.textColor = Colors.primaryTextColor
    updateMomentLabel.textColor = Colors.secondaryTextColor
    
    photoPlayView.contentMode = .Center
    titleLabel.textColor = Colors.primaryTextColor
    photoCountLabel.textColor = Colors.secondaryTextColor
    photoPlayView.backgroundColor = UIColor.darkGrayColor()
    
    // Interact buttons
    [interactButton1, interactButton2, interactButton3, interactButton4].forEach { button in
      button.addTarget(target: self, action: "handleInteraction:")
    }
    
    // Change colors
    addPhotoButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.10)
    addPhotoButton.setImage(UIImage(named: "camera-icon"), forState: .Normal)
    addPhotoButton.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8)
  }
  
  func handleInteraction(button: InteractButton) {
    addSubview(
      FloatBubble(
        frame: photoPlayView.frame,
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

      self.addSubview(
        FloatBubble(
          frame: self.photoPlayView.frame,
          interaction: interaction,
          direction: .RightToLeft,
          intensive: CGFloat(50)
        )
      )
    }
  }
  
  @IBAction func handleAddPhotoButtonTap(sender: UIButton) {
    delegate?.storyCell?(didTapAddPhotoButtonForStory: story)
  }
}

@objc protocol StoryTableViewCellDelegate {
  optional func storyCell(didTapAddPhotoButtonForStory story: Story)
}