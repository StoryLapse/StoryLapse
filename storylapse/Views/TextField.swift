//
//  TextField.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/18/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class TextField: UITextField {
  
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
