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
  var checkTapGestureRecognize = true
  var selectedIndexPath: NSIndexPath?

  override func viewDidLoad() {

    title = "Photo Detail"
    super.viewDidLoad()
    collectionView.delegate = self
    collectionView.dataSource = self
    
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    if let selectedIndexPath = selectedIndexPath {
      collectionView.scrollToItemAtIndexPath(selectedIndexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
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

  // Mark: Other


  @IBAction func onBackClicked(sender: AnyObject) {
    self.navigationController?.popViewControllerAnimated(true)
  }


  @IBAction func onTabGestureRecognize(sender: UITapGestureRecognizer) {
    print("on tap")
    if checkTapGestureRecognize == true {
      bottomView.hidden = true
      topView.hidden = true
      self.navigationController?.navigationBarHidden = true
      let screenSize: CGRect = UIScreen.mainScreen().bounds
      let screenWidth = screenSize.width
      let screenHeight = screenSize.height
      collectionView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
      checkTapGestureRecognize = false
      showAminationOnAdvert()
    }
    else if checkTapGestureRecognize == false {
      bottomView.hidden = false
      topView.hidden = false
      self.navigationController?.navigationBarHidden = false
      checkTapGestureRecognize = true
    }
  }

  func showAminationOnAdvert() {
    let transitionAnimation = CATransition();
    transitionAnimation.type = kCAEmitterBehaviorValueOverLife
    transitionAnimation.subtype = kCAEmitterBehaviorValueOverLife
    transitionAnimation.duration = 2.5
    transitionAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
    transitionAnimation.fillMode = kCAFillModeBoth
    collectionView.layer.addAnimation(transitionAnimation, forKey: "fadeAnimation")

  }


  @IBAction func onShareTouched(sender: AnyObject) {

    print("share")

    let myShare = "I am feeling *** today"

    let shareVC: UIActivityViewController = UIActivityViewController(activityItems: [myShare], applicationActivities: nil)
    self.presentViewController(shareVC, animated: true, completion: nil)
    //    print("share bubles")
    //    let shareBubles: AAShareBubbles = AAShareBubbles.init(centeredInWindowWithRadius: 100)
    //    shareBubles.delegate = self
    //    shareBubles.bubbleRadius = 40
    //    shareBubles.sizeToFit()
    //    //shareBubles.showFacebookBubble = true
    //    shareBubles.showTwitterBubble = true
    //    shareBubles.addCustomButtonWithIcon(UIImage(named: "twitter"), backgroundColor: UIColor.whiteColor(), andButtonId: 100)
    //    shareBubles.show()

  }

  @IBAction func playAutomaticPhotoImages(sender: AnyObject) {
    animateImages(0)
  }

  func animateImages(no: Int) {
    var number: Int = no
    if number == images.count - 1 {
      number = 0
    }
    let name: String = images[number]
    self.collectionView!.alpha = 0.5
    //self.collectionView.cellForItemAtIndexPath(NSIndexPath(index: number)) = UIImage(named: name)

    //code to animate bg with delay 2 and after completion it recursively calling animateImage method
    UIView.animateWithDuration(2.0, delay: 0.8, options:UIViewAnimationOptions.CurveEaseInOut, animations: {() in
      self.collectionView!.alpha = 1.0;
      },
      completion: {(Bool) in
        number++;
        self.animateImages(number);
        print(String(images[number]))
    })
  }


}
