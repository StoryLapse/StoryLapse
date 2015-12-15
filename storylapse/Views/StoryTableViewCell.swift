//
//  StoryTableViewCell.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/13/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit
import AlamofireImage

class StoryTableViewCell: UITableViewCell {
  
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var photoCountLabel: UILabel!
  @IBOutlet var thumbImageView: UIImageView!

  var story: Story! {
    didSet {
      titleLabel.text = story.title
      photoCountLabel.text = String(format: "%d photos", arguments: [story.photoCount])
      thumbImageView.af_setImageWithURL(NSURL(string: "http://lorempixel.com/160/160/sports/")!)
    }
  }
  
  override func awakeFromNib() {
    selectionStyle = .None
    backgroundColor = Colors.ebony
    
    titleLabel.textColor = Colors.primaryTextColor
    photoCountLabel.textColor = Colors.secondaryTextColor
    thumbImageView.backgroundColor = UIColor.darkGrayColor()
  }
}
