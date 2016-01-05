//
//  IntroViewController.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/24/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
  
  @IBOutlet var logoImageView: UIImageView!
  @IBOutlet var logoCenterYConstraint: NSLayoutConstraint!
  @IBOutlet var sloganLabel: UILabel!
  @IBOutlet var sloganCenterYConstraint: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    sloganLabel.alpha = 0
    sloganCenterYConstraint.constant -= 40
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    animate()
  }
  
  func animate() {
    self.view.layoutIfNeeded()
    UIView.animateWithDuration(1.5, delay: 0, options: [], animations: { () -> Void in
      self.logoCenterYConstraint.constant -= 60
      self.logoImageView.transform = CGAffineTransformMakeScale(0.8, 0.8)
      self.view.layoutIfNeeded()
      }, completion: nil)
    
    UIView.animateWithDuration(1.5, delay: 0.5, options: [], animations: { () -> Void in
      self.sloganCenterYConstraint.constant -= 30
      self.sloganLabel.alpha = 1
      self.view.layoutIfNeeded()
      }, completion: nil)
    
    NSTimer.after(2.5) {
      let walkthroughViewController = self.storyboard!.instantiateViewControllerWithIdentifier("mainViewController")
      
       walkthroughViewController.transitioningDelegate = self
      self.presentViewController(walkthroughViewController, animated: true, completion: nil)
    }
  }
}

extension IntroViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
  
  func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return self
  }
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return 1
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let containerView = transitionContext.containerView()!
    let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
    
    if let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
      where fromViewController === self {
        containerView.addSubview(toViewController.view)
        
        toViewController.view.alpha = 0
        UIView.animateWithDuration(1, animations: { () -> Void in
          toViewController.view.alpha = 1
          
          }) { finished in
            transitionContext.completeTransition(true)
        }
    }
  }
}
