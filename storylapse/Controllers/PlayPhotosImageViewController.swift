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
  
  @IBOutlet var playView: JBKenBurnsView!
  var photos: [Photo] = []
  var story: Story! {
    didSet {
      photos = Photo.getPhotos(getDatabase(), story: story)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    playView.layer.borderWidth = 1
    playView.delegate = self
    self.navigationController?.navigationBarHidden = true
    self.tabBarController?.tabBar.hidden = true
    playView.layer.borderWidth = 1
    playView.layer.borderColor = UIColor.blackColor().CGColor
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    let images = photos.map { UIImage(named: $0.localPath)! }
    playView.animateWithImages(images, transitionDuration: 6.0, initialDelay: 1.0, loop: true, isLandscape: true)
    playView.center = CGPoint(x: view.center.x , y: view.center.y)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

}
