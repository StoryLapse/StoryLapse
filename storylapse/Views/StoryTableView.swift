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
    
    separatorStyle = .SingleLine
    separatorInset = UIEdgeInsetsZero
    separatorColor = UIColor.darkGrayColor()
    rowHeight = UITableViewAutomaticDimension
    backgroundColor = Colors.ebony
    estimatedRowHeight = 100
    
    tableFooterView = UIView()
    backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1)
    backgroundView?.backgroundColor = UIColor(patternImage: UIImage(named: "camera-icon")!)
  }
}
