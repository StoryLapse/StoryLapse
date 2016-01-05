//
//  PhotoDetailViewController.swift
//  storylapse
//
//  Created by Khuong Pham on 12/10/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import Foundation
import UIKit
import AAShareBubbles
import SwipeView
import Cartography
import ChameleonFramework

class PhotoDetailViewController: UIViewController, AAShareBubblesDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var interactionWrapView: UIView!
  @IBOutlet var creatorWrapView: UIView!
  @IBOutlet var creatorAvatarImageView: UIImageView!
  @IBOutlet var creatorNameLabel: UILabel!
  @IBOutlet var updatedMomentLabel: UILabel!
  
  @IBOutlet var interactionCountButton: UIButton!
  @IBOutlet var interactButton1: InteractButton! {
    didSet {
      interactButton1.interaction = Interaction(type: .ThumbUp)
    }
  }
  @IBOutlet var interactButton2: InteractButton! {
    didSet {
      interactButton2.interaction = Interaction(type: .Heart)
    }
  }
  @IBOutlet var interactButton3: InteractButton! {
    didSet {
      interactButton3.interaction = Interaction(type: .Gorgeous)
    }
  }
  @IBOutlet var interactButton4: InteractButton! {
    didSet {
      interactButton4.interaction = Interaction(type: .Kiss)
    }
  }
  
  var isFullscreen = false
  var selectedPhotoIndex: Int?
  
  var photos: [Photo] = []
  var story: Story! {
    didSet {
      photos = Photo.getPhotos(getDatabase(), story: story)
      title = story.title
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = Colors.primaryBackgroundColor
    
    creatorAvatarImageView.backgroundColor = UIColor.darkGrayColor()
    creatorAvatarImageView.layer.cornerRadius = 2
    creatorAvatarImageView.clipsToBounds = true
    creatorNameLabel.textColor = Colors.primaryTextColor
    updatedMomentLabel.textColor = Colors.primaryTextColor
    
    collectionView.backgroundColor = Colors.primaryBackgroundColor
    collectionView.delegate = self
    collectionView.dataSource = self
    
    // Interact buttons
    [interactButton1, interactButton2, interactButton3, interactButton4].forEach { button in
      button.addTarget(target: self, action: "handleInteraction:")
    }
    
    interactionCountButton.tintColor = Colors.primaryTextColor
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    creatorAvatarImageView.af_setImageWithURL(NSURL(string: story.creatorAvatarPath)!)
    
    creatorNameLabel.text = story.creatorName
    interactionCountButton.setTitle(String(format: "%d INTERACTIONS", story.interactionCount), forState: .Normal)
    
    if let selectedPhotoIndex = selectedPhotoIndex {
      let indexPath = NSIndexPath(forItem: selectedPhotoIndex, inSection: 0)
      collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
    }
  }
  
  // MARK: Collection
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DetailCell", forIndexPath: indexPath) as! PhotoCollectionDetailViewCell
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "handlePhotoTap:")
    
    cell.photoDetailImageView.image = UIImage(named: photos[indexPath.row].localPath)
    cell.addGestureRecognizer(tapGestureRecognizer)
    
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    return collectionView.bounds.size
  }
  
  override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)
    
    
    interactionWrapView.backgroundColor = UIColor(
      gradientStyle: .TopToBottom,
      withFrame: interactionWrapView.bounds,
      andColors: [
        UIColor(red: 0, green: 0, blue: 0, alpha: 0),
        UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
      ]
    )
    
    creatorWrapView.backgroundColor = UIColor(
      gradientStyle: .TopToBottom,
      withFrame: creatorWrapView.bounds,
      andColors: [
        UIColor(red: 0, green: 0, blue: 0, alpha: 0.8),
        UIColor(red: 0, green: 0, blue: 0, alpha: 0)
      ]
    )
    
    collectionView.reloadData()
  }
  
  func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
    updatedMomentLabel.text = photos[indexPath.item].updatedMoment
    resizeCollectionView()
  }
  
  func resizeCollectionView() {
    if isFullscreen {
      let screenSize = UIScreen.mainScreen().bounds
      collectionView.frame = screenSize
      
    } else {
      collectionView.layoutIfNeeded()
    }
  }
  
  func handlePhotoTap(sender: UITapGestureRecognizer) {
    isFullscreen = !isFullscreen
    
    navigationController?.navigationBarHidden = isFullscreen
    (tabBarController as! SLTabBarController).toggleTabBar(animated: true, showed: !isFullscreen)

    interactionWrapView.hidden = isFullscreen
    creatorWrapView.hidden = isFullscreen
    
    collectionView.reloadData()
  }
  
  @IBAction func onShareTouched(sender: AnyObject) {
    let myShare = "My beautiful photo! <3 <3"
    let image: UIImage = UIImage(named: photos[selectedPhotoIndex!].localPath)!
    
    let shareVC: UIActivityViewController = UIActivityViewController(activityItems: [(image), myShare], applicationActivities: nil)
    self.presentViewController(shareVC, animated: true, completion: nil)
  }
  
  @IBAction func handleMenuButtonTap(sender: AnyObject) {
    let menuViewController = MenuViewController(items:
      [
        MenuViewItem(title: "Report", iconImage: UIImage(named: "warning-menu-icon")) {
          print("Reported")
        },
        MenuViewItem(title: "Delete", iconImage: UIImage(named: "garbage-bin-menu-icon")) {
          print("Deleted")
        },
        MenuViewItem(title: "Cancel", iconImage: UIImage(named: "cross-menu-icon"), type: .Cancel)
      ]
    )
    
    presentViewController(menuViewController, animated: true, completion: nil)
  }
  
  
  func handleInteraction(button: InteractButton) {
    view.addSubview(
      FloatBubble(
        frame: collectionView.frame,
        interaction: button.interaction,
        direction: .LeftToRight,
        intensive: CGFloat(50)
      )
    )
    
    NSTimer.after(0.5) { () -> Void in
      let interaction = [
        Interaction(type: .ThumbUp),
        Interaction(type: .Heart),
        Interaction(type: .Gorgeous),
        Interaction(type: .Kiss)
        ][Int(arc4random_uniform(4))]
      
      self.view.addSubview(
        FloatBubble(
          frame: self.collectionView.frame,
          interaction: interaction,
          direction: .RightToLeft,
          intensive: CGFloat(50)
        )
      )
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "Play" {
      let playPhotoImageVC = segue.destinationViewController as! PlayPhotosImageViewController
      playPhotoImageVC.story = story
    }
  }
  
  @IBAction func handleInteractionsCountButtonTap(sender: AnyObject) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let loginVC = storyboard.instantiateViewControllerWithIdentifier("UserListViewController") as! UserListViewController
    let navigation = UINavigationController(rootViewController: loginVC)
    let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "backAction")
    navigation.navigationBar.topItem!.leftBarButtonItem = backButton
    
    self.presentViewController(navigation, animated: true, completion: nil)
  }
}
