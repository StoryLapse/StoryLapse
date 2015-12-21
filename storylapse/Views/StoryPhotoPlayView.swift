//
//  StoryPhotoPlayView.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/19/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit
import SwiftyTimer

class StoryPhotoPlayView: UIView {
  
  var enterTime: NSTimeInterval = 0.5
  var delayTime: NSTimeInterval = 4
  
  private var timer: NSTimer?
  
  var photos: [Photo] = []
  private var currentPhotoIndex = 0
  
  var story: Story! {
    didSet {
      photos = Photo.getPhotos(getDatabase(), story: story)
    }
  }
  
  var isStatic: Bool = false {
    didSet {
      stop()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    clipsToBounds = true
  }
  
  private func sizeForImage(image: UIImage) -> CGSize {
    let size = image.size
    let ratio = size.width / size.height
    let boundsRatio = bounds.width / bounds.height
    let width = ratio < boundsRatio ? bounds.width : ratio * bounds.height
    let height = ratio > boundsRatio ? bounds.height : bounds.width / ratio
    
    return CGSizeMake(width, height)
  }
  
  private func imageView(photo photo: Photo) -> UIImageView {
    let image = UIImage(named: photo.localPath)!
    let imageView = UIImageView(frame: bounds)
    let imageSize = sizeForImage(image)
    
    imageView.frame = CGRectMake(0, 0, imageSize.width, imageSize.height)
    imageView.image = image
    
    return imageView
  }
  
  private func animateImageView(first first: Bool = false) {
    let tweenAnimateTime = enterTime + delayTime + enterTime
    let imageView = subviews.last!
    let nextFrame = CGRectOffset(imageView.frame, bounds.width - imageView.frame.width, bounds.height - imageView.frame.height)
    
    if (!first) {
      imageView.alpha = 0
      UIView.animateWithDuration(enterTime) {
        imageView.alpha = 1
      }
    }
    
    UIView.animateWithDuration(tweenAnimateTime, animations: {
      imageView.frame = nextFrame
      }, completion: { finished in
        imageView.removeFromSuperview()
    })
  }
  
  private func next(first: Bool = false) {
    let photo = photos[++currentPhotoIndex % photos.count]
    let nextImageView = imageView(photo: photo)
    
    addSubview(nextImageView)
    animateImageView(first: first)
  }
  
  func play() {
    timer?.invalidate()
    if photos.count == 0 {
      return
    }
    
    next(true)
    timer = NSTimer.every(enterTime + delayTime) { self.next() }  }
  
  func stop() {
    currentPhotoIndex = 0
    timer?.invalidate()
  }
  
  override func willMoveToWindow(newWindow: UIWindow?) {
    if newWindow == nil {
      stop()
    }
  }
}
