//
//  VideoEditViewController.swift
//  storylapse
//
//  Created by huy ngo on 12/20/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer

class VideoEditViewController: UIViewController, UIVideoEditorControllerDelegate, UINavigationControllerDelegate {
  
  @IBOutlet var playerView: UIView!
  var videoURL = NSURL()
  var moviePlayer:MPMoviePlayerController!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.navigationController?.navigationBar.hidden = false
      self.navigationController?.navigationItem.backBarButtonItem?.action = "handleBackButton"
      //playVideo(videoURL)
      moviePlayer = MPMoviePlayerController(contentURL: videoURL)
      moviePlayer.view.frame = playerView.bounds
      //moviePlayer.view.sizeToFit()
      moviePlayer.scalingMode = .AspectFill
      moviePlayer.fullscreen = true
      moviePlayer.controlStyle = .Embedded
      //moviePlayer.movieSourceType = .File
      moviePlayer.repeatMode = .One
      moviePlayer.play()
      self.view.addSubview(moviePlayer.view)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  func playVideo(url: NSURL) {
    let player = AVPlayer(URL: url)
    let playerController = AVPlayerViewController()
    playerController.player = player
    self.presentViewController(playerController, animated: true) {
      player.play()
    }
  }
  @IBAction func handleEditButton(sender: AnyObject) {
    let videoEditor = UIVideoEditorController()
    videoEditor.delegate = self
    let videoString = videoURL.absoluteString
    if UIVideoEditorController.canEditVideoAtPath(videoString) {
      videoEditor.videoPath = String(videoString)
      presentViewController(videoEditor, animated: true, completion: nil)
    } else {
      print("can't edit video " );
    }
  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
  func handleBackButton() {
    print("pressed")
  }
//  override func willMoveToParentViewController(parent: UIViewController?) {
//    if parent == nil {
//      performSegueWithIdentifier("backSegue", sender: self)
//      print("This VC is 'will' be popped. i.e. the back button was pressed.")
//    }
//  }
}
