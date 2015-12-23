//
//  InteractButton.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/23/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class InteractButton: UIVisualEffectView {
  
  var iconImageView = UIImageView(image: UIImage(named: "kiss-icon"))
  private var targets = [(AnyObject, Selector)]()
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    layer.cornerRadius = 3
    clipsToBounds = true
    backgroundColor = UIColor.clearColor()
    effect = UIBlurEffect(style: .ExtraLight)
    
    iconImageView.frame = CGRectMake(0, 4, bounds.width, bounds.height - 8)
    iconImageView.contentMode = .ScaleAspectFit
    addSubview(iconImageView)
    
    addGestureRecognizer(UITapGestureRecognizer(target: self, action: "handleTap:"))
  }
  
  func addTarget(target target: AnyObject!, action: Selector) {
    targets.append((target, action))
  }
  
  func handleTap(tapGestureRecognizer: UITapGestureRecognizer) {
    targets.forEach { (target, selector) in
      target.performSelector(selector, withObject: self)
    }
  }
}
