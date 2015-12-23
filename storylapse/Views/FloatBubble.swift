//
//  FloatBubble.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/23/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class FloatBubble: UIView {
  enum Direction {
    case LeftToRight
    case RightToLeft
  }
  
  var direction: Direction!
  var intensive: CGFloat!
  
  var bubbleView: UIView!
  var iconImageView: UIImageView!
  
  convenience init(frame: CGRect, direction: Direction, intensive: CGFloat) {
    self.init(frame: frame)

    self.direction = direction
    self.intensive = intensive
    
    bubbleView = UIView(frame: CGRectMake(0, bounds.height / 2, 50, 50))
    
    let bubbleImageView = UIImageView(image: UIImage(named: "bubble-background"))
    bubbleImageView.contentMode = .ScaleAspectFit
    
    iconImageView = UIImageView(image: UIImage(named: "kiss-icon"))
    iconImageView.contentMode = .Center
    
    bubbleImageView.frame = bubbleView.bounds
    iconImageView.frame = bubbleView.bounds
    
    bubbleView.addSubview(bubbleImageView)
    bubbleView.addSubview(iconImageView)
    
    userInteractionEnabled = false
    
    addSubview(bubbleView)
    
    if direction == .RightToLeft {
      transform = CGAffineTransformMakeScale(-1, 1)
      iconImageView.transform = CGAffineTransformMakeScale(-1, 1)
    }
    
    animate()
  }
  
  func animate() {
    bubbleView.alpha = 0
    bubbleView.transform = CGAffineTransformMakeScale(0.7, 0.7)
    
    UIView.animateWithDuration(0.2) { () -> Void in
      self.bubbleView.alpha = 1
    }
    
    UIView.animateWithDuration(1, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
      self.bubbleView.frame.origin.y -= self.bubbleView.frame.height / 2
      self.bubbleView.frame.origin.x += self.intensive
      self.bubbleView.transform = CGAffineTransformMakeScale(1, 1)
      
      }) { finished in
        self.removeFromSuperview()
    }
    
    NSTimer.after(0.8) { () -> Void in
      UIView.animateWithDuration(0.2) { () -> Void in
        self.bubbleView.alpha = 0
      }
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
  
  override func willMoveToSuperview(newSuperview: UIView?) {
    super.willMoveToSuperview(newSuperview)
  }
}
