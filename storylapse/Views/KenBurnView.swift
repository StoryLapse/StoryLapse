//
//  KenBurnView.swift
//  storylapse
//
//  Created by Khuong Pham on 12/18/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit
import JBKenBurnsView

class KenBurnView: JBKenBurnsView, KenBurnsViewDelegate {

  var photos: [Photo] = []
  var story: Story! {
    didSet {
      photos = Photo.getPhotos(getDatabase(), story: story)
    }
  }

  @IBOutlet var kenBurnView: JBKenBurnsView!

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    initSubviews()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    initSubviews()
  }

  func initSubviews() {
    kenBurnView.delegate = self
    let nib = UINib(nibName: "KenBurnView", bundle: nil)
    nib.instantiateWithOwner(self, options: nil)
    addSubview(kenBurnView)

    let images = photos.map { UIImage(named: $0.localPath)! }
    kenBurnView.animateWithImages(images, transitionDuration: 6.0, initialDelay: 1.0, loop: true, isLandscape: true)
  }
  
}