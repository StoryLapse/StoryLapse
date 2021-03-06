//
//  SLNavigationController.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/8/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class SLNavigationController: UINavigationController {
  
  var context: [String: AnyObject?] = [:]
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    navigationBar.barTintColor = Colors.ebony
    navigationBar.barStyle = .Black
    
    navigationBar.titleTextAttributes = [
      NSFontAttributeName: UIFont(name: "Helvetica-Light", size: 20)!
    ]
  }
  
  func handleCameraButtonTap(sender: AnyObject?) {
    performSegueWithIdentifier("showPhotoSettingsSegue", sender: nil)
  }
}
extension UINavigationController {
    public override func shouldAutorotate() -> Bool {
        if visibleViewController is CameraViewController {
            return false
        }
        return true
    }
}