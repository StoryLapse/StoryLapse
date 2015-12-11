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

class PhotoDetailViewController: UIViewController, AAShareBubblesDelegate {

    
    @IBOutlet var topView: UIView!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var photoImageView: UIImageView!
    var photoImage = UIImage()
    var checkTapGestureRecognize = true

    override func viewDidLoad() {
        
        title = "Photo Detail"
        super.viewDidLoad()
        photoImageView.image = photoImage
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

}
