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
  @IBOutlet var photoPlayView: StoryPhotoPlayView!
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
    
    cardView.backgroundColor = Colors.ebony
    photoPlayView.contentMode = .Center
    titleLabel.textColor = Colors.primaryTextColor
    photoCountLabel.textColor = Colors.secondaryTextColor
    photoPlayView.backgroundColor = UIColor.darkGrayColor()
    
    // Change colors
    addPhotoButton.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.10)
    addPhotoButton.setImage(UIImage(named: "camera-icon"), forState: .Normal)
    addPhotoButton.imageEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8)
  }
  
  @IBAction func handleAddPhotoButtonTap(sender: UIButton) {
    delegate?.storyCell?(didTapAddPhotoButtonForStory: story)
  }
}

@objc protocol StoryTableViewCellDelegate {
  optional func storyCell(didTapAddPhotoButtonForStory story: Story)
}