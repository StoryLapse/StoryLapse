//
//  StoryTableView.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/13/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class StoryTableView: UITableView {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    separatorStyle = .SingleLine
    separatorInset = UIEdgeInsetsZero
    rowHeight = UITableViewAutomaticDimension
    estimatedRowHeight = 100
  }
}
