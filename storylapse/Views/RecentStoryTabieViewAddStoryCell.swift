//
//  RecentStoryTabieViewAddStoryCell.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/17/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class RecentStoryTableViewAddStoryCell: UITableViewCell {
  
  @IBOutlet var addNewStoryLabel: UILabel!
  @IBOutlet var plusIconImageView: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    selectionStyle = .None
    backgroundColor = Colors.ebony
    
    addNewStoryLabel.textColor = Colors.primaryTextColor
    plusIconImageView.image = plusIconImageView.image?.imageWithRenderingMode(.AlwaysTemplate)
    plusIconImageView.tintColor = Colors.secondaryTextColor
  }
}
