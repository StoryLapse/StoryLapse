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

class PhotoDetailViewController: UIViewController, AAShareBubblesDelegate {


  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var topView: UIView!
  @IBOutlet var bottomView: UIView!
  @IBOutlet var photoImageView: UIImageView!
  var photoImage = UIImage()
  var checkTapGestureRecognize = true

  override func viewDidLoad() {

    title = "Photo Detail"
    super.viewDidLoad()
    photoImageView.image = photoImage
    scrollPhotoView()
  }

  func scrollPhotoView() {

    scrollView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, self.scrollView.frame.height)
    //    let scrollViewHeight = self.scrollView.frame.height
    let scrollViewWidth = self.scrollView.frame.width
    let scrollViewHeight = UIScreen.mainScreen().bounds.size.height

    for position in 0...images.count - 1 {
      let imageScroll = UIImageView(frame: CGRectMake(scrollViewWidth * CGFloat(position), 0, scrollViewWidth, scrollViewHeight))
      imageScroll.image = UIImage(named: images[position])
      self.scrollView.addSubview(imageScroll)
    }

    let imagesCount: CGFloat = CGFloat(images.count)

    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.width * imagesCount, self.scrollView.frame.height)

  }

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
      photoImageView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
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
    photoImageView.layer.addAnimation(transitionAnimation, forKey: "fadeAnimation")

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
    self.photoImageView!.alpha = 0.5
    self.photoImageView!.image = UIImage(named: name)

    //code to animate bg with delay 2 and after completion it recursively calling animateImage method
    UIView.animateWithDuration(2.0, delay: 0.8, options:UIViewAnimationOptions.CurveEaseInOut, animations: {() in
      self.photoImageView!.alpha = 1.0;
      },
      completion: {(Bool) in
        number++;
        self.animateImages(number);
        print(String(images[number]))
    })
  }


}
