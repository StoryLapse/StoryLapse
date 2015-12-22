//
//  MenuItem.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/21/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class MenuItemView: UIView {
  
  typealias TapHandler = () -> Void
  
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
  
  var item: MenuViewItem! {
    didSet {
      titleLabel.text = item.title
      iconImageView.image = item.iconImage
    }
  }
  
  var tapHandler: TapHandler?
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
  }
  
  init(frame: CGRect, item: MenuViewItem, onTap tapHandler: TapHandler?) {
    super.init(frame: frame)
    
    self.tapHandler = tapHandler
    initSubViews(item: item)
  }
  
  private func initSubViews(item item: MenuViewItem) {
    let nib = UINib(nibName: "MenuItemView", bundle: nil)
    nib.instantiateWithOwner(self, options: nil)
    
    if item.type == .Cancel {
      let topBorderView = UIView(frame: CGRectMake(0, 0, bounds.width, 1))
      topBorderView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
      view.addSubview(topBorderView)
    }
    
    view.frame = bounds
    iconImageView.contentMode = .Center
    titleLabel.alpha = 0.8
    iconImageView.alpha = 0.8
    
    addSubview(view)
    self.item = item
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
    if (isTouchesInsideView(touches)) {
      self.tapHandler?()
    }
  }
}
