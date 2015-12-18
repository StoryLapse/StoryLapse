//
//  PlayPhotosImageViewController.swift
//  storylapse
//
//  Created by Khuong Pham on 12/17/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit
import JBKenBurnsView

class PlayPhotosImageViewController: UIViewController, KenBurnsViewDelegate {

  @IBOutlet var kenBurnView: KenBurnView!

  var photos: [Photo] = []
    var story: Story! {
      didSet {
        photos = Photo.getPhotos(getDatabase(), story: story)
      }
    }

  override func viewDidLoad() {
    super.viewDidLoad()

    kenBurnView.delegate = self
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

    kenBurnView = KenBurnView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
    view.addSubview(kenBurnView)
    let images = photos.map { UIImage(named: $0.localPath)! }
    kenBurnView.animateWithImages(images, transitionDuration: 4.0, initialDelay: 1.0, loop: true, isLandscape: true)
  }

}
