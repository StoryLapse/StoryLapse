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

class PhotoDetailViewController: UIViewController, AAShareBubblesDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  @IBOutlet var collectionView: UICollectionView!
  @IBOutlet var topView: UIView!
  @IBOutlet var bottomView: UIView!
  var isFullscreen = false
  var selectedIndexPath: NSIndexPath?

  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Photo Detail"
    collectionView.delegate = self
    collectionView.dataSource = self
    
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    if let selectedIndexPath = selectedIndexPath {
      collectionView.scrollToItemAtIndexPath(selectedIndexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
    }
  }

  // MARK: Collection
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }

  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DetailCell", forIndexPath: indexPath) as! PhotoCollectionDetailViewCell
    cell.photoDetailImageView.image = UIImage(named: images[indexPath.row])
    cell.photoDetailImageView.alpha = 0

    let millisecondDelay = UInt64(arc4random() % 600) / 1000

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(millisecondDelay * NSEC_PER_SEC)), dispatch_get_main_queue(),({ () -> Void in

      UIView.animateWithDuration(0.5, animations: ({
        cell.photoDetailImageView.alpha = 1.0
      }))
    }))

    return cell
  }

  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    return CGSizeMake(screenSize.width, screenSize.height - topView.frame.height - bottomView.frame.height)
  }

  override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)

    collectionView.reloadData()
  }


  // MARK: OnBack


  @IBAction func onBackClicked(sender: AnyObject) {
    self.navigationController?.popViewControllerAnimated(true)
  }

  // MARK: onTabGesture ImageView


  @IBAction func handlePhotoTap(sender: UITapGestureRecognizer) {
    if !isFullscreen {
      bottomView.hidden = true
      topView.hidden = true
      self.tabBarController?.tabBar.hidden = true
      self.navigationController?.navigationBarHidden = true
      
      let screenSize: CGRect = UIScreen.mainScreen().bounds
      let screenWidth = screenSize.width
      let screenHeight = screenSize.height
      collectionView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
      
    } else {
      bottomView.hidden = false
      topView.hidden = false
      self.tabBarController?.tabBar.hidden = false
      self.navigationController?.navigationBarHidden = false
    }
    
    isFullscreen = !isFullscreen
  }

  // MARK: Share


  @IBAction func onShareTouched(sender: AnyObject) {

    print("share")

    let myShare = "I am feeling *** today"

    let shareVC: UIActivityViewController = UIActivityViewController(activityItems: [myShare], applicationActivities: nil)
    self.presentViewController(shareVC, animated: true, completion: nil)

  }

  // MARK: Play automatic

  @IBAction func playAutomaticPhotoImages(sender: AnyObject) {
    if selectedIndexPath?.row < images.count - 1 {
      NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "update", userInfo: nil, repeats: true)
    }
  }

  func update() {
    collectionView.scrollToItemAtIndexPath(selectedIndexPath!, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
    selectedIndexPath = NSIndexPath(forRow: (selectedIndexPath!.row + 1) % images.count, inSection: 0)
  }

}
