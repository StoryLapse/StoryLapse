//
//  MenuViewController.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/21/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
  
  typealias Item = MenuViewItem
  
  var menuView: UIView!
  lazy var backdropView: UIView = {
    let view = UIView(frame: self.view.bounds)
    view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    return view
  }()
  var menuHeight: CGFloat! = 50
  var items: [Item]!
  private var isPresenting: Bool = false

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  init(items: [Item]?) {
    super.init(nibName: nil, bundle: nil)
    
    self.items = items ?? []
    
    modalPresentationStyle = .Custom
    transitioningDelegate = self
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let menuViewHeight = CGFloat(items.count) * menuHeight
    
    menuView = UIView(frame: CGRectMake(0, view.bounds.height - menuViewHeight, view.bounds.width, menuViewHeight))
    
    let menuItemViews: [MenuItemView] = items.enumerate().map { t in
      let y = CGFloat(t.0) * menuHeight

      return MenuItemView(
        frame: CGRectMake(0, y, view.bounds.width, menuHeight),
        item: t.1
        ) {
          self.dismissViewControllerAnimated(true, completion: nil)
          t.1.tapHandler?()
      }
    }
    
    menuItemViews.forEach { menuView.addSubview($0) }
    
    view.addSubview(backdropView)
    view.addSubview(menuView)
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
    backdropView.addGestureRecognizer(tapGestureRecognizer)
  }
  
  func handleTap(sender: UITapGestureRecognizer!) {
    if sender.view === backdropView {
      dismissViewControllerAnimated(true, completion: nil)
    }
  }
}

// MARK: Transition delegate
extension MenuViewController: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
  func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return self
  }
  
  func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return self
  }
  
  func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
    return 1
  }
  
  func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let containerView = transitionContext.containerView()!
    let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
    
    if let toViewController = toViewController where toViewController === self {
      containerView.addSubview(toViewController.view)
      
      menuView.frame.origin.y += menuView.frame.height
      backdropView.alpha = 0
      
      UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
        self.menuView.frame.origin.y -= self.menuView.frame.height
        self.backdropView.alpha = 1
        }, completion: { finished in
          transitionContext.completeTransition(true)
      })
      
    } else {
      UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: { () -> Void in
        self.menuView.frame.origin.y += self.menuView.frame.height
        self.backdropView.alpha = 0
        }, completion: { finished in
          transitionContext.completeTransition(true)
      })
    }
  }
}