//
//  TextView.swift
//  storylapse
//
//  Created by Khuong Pham on 12/20/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class TextView: UITextView {

  override func awakeFromNib() {
    super.awakeFromNib()

    backgroundColor = Colors.canvasColor
    textColor = Colors.primaryTextColor
    layer.borderWidth = 1
    layer.borderColor = Colors.borderColor.CGColor
//    attributedPlaceholder = NSAttributedString(string: placeholder!,
//      attributes:[NSForegroundColorAttributeName: Colors.placeholderTextColor])

  }
}
