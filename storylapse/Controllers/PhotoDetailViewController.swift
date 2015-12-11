//
//  PhotoDetailViewController.swift
//  storylapse
//
//  Created by Khuong Pham on 12/10/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import Foundation
import UIKit

class PhotoDetailViewController: UIViewController {

    
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
        }
        else if checkTapGestureRecognize == false {
            bottomView.hidden = false
            topView.hidden = false
            self.navigationController?.navigationBarHidden = false
            checkTapGestureRecognize = true
        }
    }
}
