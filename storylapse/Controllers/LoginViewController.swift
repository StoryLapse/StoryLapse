//
//  LoginViewController.swift
//  storylapse
//
//  Created by Khuong Pham on 12/20/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit
import OAuthSwift

class LoginViewController: UIViewController {
  
  @IBOutlet var laterButton: UIButton! {
    didSet {
      laterButton.tintColor = Colors.secondaryTextColor
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = Colors.primaryBackgroundColor
  }
  
  @IBAction func handleFacebookLoginButtonTap(sender: AnyObject) {
    User.loginFacebook(getDatabase()) { _ in
      Story.updateCurrentUserStories(getDatabase())
      self.dismissViewControllerAnimated(true, completion: nil)
    }
  }
  
  @IBAction func handleLaterButtonTap(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
}
