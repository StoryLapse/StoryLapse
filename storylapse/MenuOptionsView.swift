//
//  MenuOptionsView.swift
//  storylapse
//
//  Created by Khuong Pham on 12/17/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import Foundation
import UIKit

class MenuOptionsView: UIView {

  @IBOutlet var shareTwitterImageView: UIImageView!
  @IBOutlet var shareFacebookImageView: UIImageView!
  @IBOutlet var containerView: UIView!
  @IBOutlet var shareLabel: UILabel!
  @IBOutlet var shareImageView: UIImageView!
  @IBOutlet var deleteLabel: UILabel!
  @IBOutlet var deleteImageView: UIImageView!
  @IBOutlet var buildGifFileLabel: UILabel!
  @IBOutlet var buildGifFileImageView: UIImageView!

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    initSubviews()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    initSubviews()
  }

  func initSubviews() {
    let nib = UINib(nibName: "MenuOptionsView", bundle: nil)
    nib.instantiateWithOwner(self, options: nil)
    let borderColor = UIColor(red: 0, green: 0, blue: 222, alpha: 0.5).CGColor
    containerView.frame = bounds

    containerView.layer.borderWidth = 1.5
    containerView.layer.borderColor = borderColor

    shareFacebookImageView.layer.borderWidth = 0.5
    shareTwitterImageView.layer.borderWidth = 0.5
    shareFacebookImageView.layer.borderColor = borderColor
    shareTwitterImageView.layer.borderColor = borderColor

    deleteLabel.layer.borderWidth = 0.5
    buildGifFileLabel.layer.borderWidth = 0.5
    deleteLabel.layer.borderColor = borderColor
    buildGifFileLabel.layer.borderColor = borderColor

    deleteImageView.layer.borderWidth = 0.5
    deleteImageView.layer.borderColor = borderColor
    buildGifFileImageView.layer.borderWidth = 0.5
    buildGifFileImageView.layer.borderColor = borderColor

    shareLabel.layer.borderColor = borderColor
    shareLabel.layer.borderWidth = 0.5
    shareImageView.layer.borderWidth = 0.5
    shareImageView.layer.borderColor = borderColor

    addSubview(containerView)
  }


  @IBAction func handleViewTap(sender: UITapGestureRecognizer) {

    // Share

    // Delete

    // Build Gif File
  }
}