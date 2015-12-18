//
//  StoryTableView.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/13/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit
import AlamofireImage

class StoryTableView: UITableView {
  
  override func awakeFromNib() {
    super.awakeFromNib()

    rowHeight = UITableViewAutomaticDimension
    estimatedRowHeight = 100
    
    separatorStyle = .SingleLine
    separatorInset = UIEdgeInsetsZero
    separatorColor = UIColor.darkGrayColor()
    backgroundColor = Colors.ebony
    
    tableFooterView = UIView()
    backgroundColor = Colors.primaryBackgroundColor
  }
}
