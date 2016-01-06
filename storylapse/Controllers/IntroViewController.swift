//
//  IntroViewController.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/24/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit
import Alamofire

class IntroViewController: UIViewController {
  
  @IBOutlet var logoImageView: UIImageView!
  @IBOutlet var logoCenterYConstraint: NSLayoutConstraint!
  @IBOutlet var sloganLabel: UILabel!
  @IBOutlet var sloganCenterYConstraint: NSLayoutConstraint!
  
  private var settingUp: Bool = false
  
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
      self.pushWalkthroughViewController()
    }
  }
  
  func pushWalkthroughViewController() {
    
    let walkthroughViewController = self.storyboard!.instantiateViewControllerWithIdentifier("mainViewController")
    
    walkthroughViewController.transitioningDelegate = self
    
    if !self.settingUp {
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


extension IntroViewController {
  
  @IBAction func handleSetupButtonTap(sender: UIButton) {
    let apiURLPrefix = "http://103.47.192.73:2292"
    let db = try! CBLManager.sharedInstance().databaseNamed("storylapse")
    
    let query = db.createAllDocumentsQuery()
    let results = try! query.run()
    
    let fileManager = NSFileManager.defaultManager()
    
    results.forEach { item in
      let doc = item.document!!
      
      if let creatorId = doc.properties!["creatorId"] as? String {
        if creatorId != User.currentUser.id {
          if doc.properties!["type"] as? String == Photo.type {
            let photo = Photo(forDocument: doc)
            
            try! fileManager.removeItemAtPath(photo.localPath)
          }
          
          try! doc.deleteDocument()
        }
      }
    }
    
    settingUp = true
    sender.setTitle("Setting up...", forState: .Normal)
    
    func newDoc() -> CBLDocument {
      return db.documentWithID(NSUUID().UUIDString.lowercaseString)!
    }
    
    func downloadPhoto(photo: Photo) {
      let url = NSURL(string: photo.remoteUrl!)!
      let id = photo.id
      
      if let data = NSData(contentsOfURL: url) {
        let image = UIImage(data: data)!
        let fileURL = Photo.getPhotoDirURL().URLByAppendingPathComponent(id + ".jpg")
        
        if let pngImageData = UIImageJPEGRepresentation(image, 1) {
          pngImageData.writeToURL(fileURL, atomically: false)
        }
        print("downloaded at:\(fileURL)")
      }
    }
    
    Alamofire.request(.GET, "\(apiURLPrefix)/api/v1/stories")
      .responseJSON { response in
        var photos = [Photo]()
        let stories: [Story] = (response.result.value as! [NSDictionary]).map { rawData in
          let story = Story(forDocument: newDoc())
          
          story.title = rawData["title"] as! String
          story.hashtags = rawData["hashtags"] as! [String]
          
          story.interactionCount = 0
          story.commentCount = 0
          
          story.creatorName = rawData["creatorName"] as! String
          story.creatorAvatarPath = rawData["creatorAvatarPath"] as! String
          
          story.creatorId = newDoc().documentID
          story.createdAt = NSDate()
          
          (rawData["photoPaths"] as! [String]).map { photoPath in
            let photo = Photo(forDocument: newDoc())
            
            photo.remoteUrl = "\(apiURLPrefix)\(photoPath)"
            photo.interactionCount = 0
            
            photo.createdAt = NSDate()
            photo.creatorId = story.creatorId
            photos += [photo]
            
            story.photoIds += [photo.id]
          }
          
          return story
        }
        
        photos.forEach { photo in
          downloadPhoto(photo)
          try! photo.save()
        }
        
        stories.forEach { story in
          try! story.save()
        }
        
        self.settingUp = false
        self.pushWalkthroughViewController()
    }
  }
}