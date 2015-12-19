//
//  PlayPhotosImageViewController.swift
//  storylapse
//
//  Created by Khuong Pham on 12/17/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit
import JBKenBurnsView
import ReplayKit

class PlayPhotosImageViewController: UIViewController, KenBurnsViewDelegate, RPPreviewViewControllerDelegate {

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

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)

    kenBurnView = KenBurnView.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
    view.addSubview(kenBurnView)
    let images = photos.map { UIImage(named: $0.localPath)! }
    kenBurnView.animateWithImages(images, transitionDuration: 4.0, initialDelay: 1.0, loop: true, isLandscape: true)
  }

  override func shouldAutorotate() -> Bool {
    return true
  }

// MARK: Handle Record Button

  @IBAction func handleRecordVideoButtonTap(sender: AnyObject) {
    print("record")
    startRecording()
  }

  func startRecording() {
    print("start recording")
    let recorder = RPScreenRecorder.sharedRecorder()

    recorder.startRecordingWithMicrophoneEnabled(true) { [unowned self] (error) in
      if let unwrappedError = error {
        print(unwrappedError.localizedDescription)
      } else {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Stop", style: .Plain, target: self, action: "stopRecording")
      }
    }
  }

  func stopRecording() {
    print("stop recording")
    let recorder = RPScreenRecorder.sharedRecorder()

    recorder.stopRecordingWithHandler { [unowned self] (preview, error) in
      self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Start", style: .Plain, target: self, action: "startRecording")

      if let unwrappedPreview = preview {
        unwrappedPreview.previewControllerDelegate = self
        self.presentViewController(unwrappedPreview, animated: true, completion: nil)
      }
    }
  }

  func previewControllerDidFinish(previewController: RPPreviewViewController) {
    print("preview")
    dismissViewControllerAnimated(true, completion: nil)
  }

}
