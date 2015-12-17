//
//  RecentStoryTableViewCell.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/17/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class RecentStoryTableViewCell: UITableViewCell {
  
  @IBOutlet var thumbImageView: UIImageView!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var photoCountLabel: UILabel!

  var story: Story! {
    didSet {
      titleLabel.text = story.title
      photoCountLabel.text = String(format: "%d photos", arguments: [story.photoCount])
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    selectionStyle = .None
    backgroundColor = Colors.ebony
    
    titleLabel.textColor = Colors.primaryTextColor
    photoCountLabel.textColor = Colors.secondaryTextColor
    thumbImageView.backgroundColor = UIColor.darkGrayColor()
  }
}
