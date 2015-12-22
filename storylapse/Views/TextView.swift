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
    layer.borderColor = UIColor.clearColor().CGColor
  }
}
