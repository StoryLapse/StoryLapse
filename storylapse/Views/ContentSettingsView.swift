//
//  ContentSettingsView.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/15/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class ContentSettingsView: UIView {
  
  @IBOutlet var captionTextView: UITextView!
  @IBOutlet var storyLabel: UILabel!
  @IBOutlet var storyTitleTextField: ContentSettingsTextField!
  
  override func awakeFromNib() {
    backgroundColor = UIColor(red: 0.11, green: 0.11, blue: 0.11, alpha: 1)
    
    captionTextView.backgroundColor = Colors.canvasColor
    captionTextView.textColor = Colors.primaryTextColor
    captionTextView.indicatorStyle = .White
    captionTextView.layer.borderColor = Colors.borderColor.CGColor
    captionTextView.layer.borderWidth = 1
    captionTextView.textContainerInset = UIEdgeInsetsMake(8, 8, 8, 8)
    
    storyLabel.textColor = Colors.primaryTextColor
  }
}

class ContentSettingsTextField: UITextField {
  override func awakeFromNib() {
    super.awakeFromNib()
    
    backgroundColor = Colors.canvasColor
    textColor = Colors.primaryTextColor
    layer.borderWidth = 1
    layer.borderColor = Colors.borderColor.CGColor
    attributedPlaceholder = NSAttributedString(string: placeholder!,
      attributes:[NSForegroundColorAttributeName: Colors.placeholderTextColor])

  }
}