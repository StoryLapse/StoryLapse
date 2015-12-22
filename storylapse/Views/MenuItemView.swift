//
//  MenuItem.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/21/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class MenuItemView: UIView {
  
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var iconImageView: UIImageView!
  @IBOutlet private var view: UIView!
  
  private var touchingDown: Bool = false {
    didSet {
      view.backgroundColor = touchingDown ?
        UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1):
        UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
  }
  
  var title: String? {
    didSet {
      titleLabel.text = title
    }
  }
  
  var iconImage: UIImage? {
    didSet {
      iconImageView.image = iconImage
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  }
  
  init(frame: CGRect, title: String? = nil, iconImage: UIImage? = nil) {
    super.init(frame: frame)
    
    initSubViews(title: title, iconImage: iconImage)
  }
  
  private func initSubViews(title title: String? = nil, iconImage: UIImage? = nil) {
    let nib = UINib(nibName: "MenuItemView", bundle: nil)
    nib.instantiateWithOwner(self, options: nil)
    
    let topBorderView = UIView(frame: CGRectMake(0, 0, bounds.width, 1))
    
    topBorderView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
    view.frame = bounds
    iconImageView.contentMode = .Center
    view.addSubview(topBorderView)
    addSubview(view)
    
    self.title = title
    self.iconImage = iconImage
  }
  
  private func isTouchesInsideView(touches: Set<UITouch>) -> Bool {
    let touch = touches.first!
    let touchPoint = touch.locationInView(view)
    
    return CGRectContainsPoint(view.frame, touchPoint)
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    touchingDown = true
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    touchingDown = isTouchesInsideView(touches)
  }
  
  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    touchingDown = false
    print(isTouchesInsideView(touches))
  }
}
