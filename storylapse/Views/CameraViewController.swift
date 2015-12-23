//
//  CameraViewController.swift
//  storylapse
//
//  Created by huy ngo on 12/14/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit
import CameraManager
import AVFoundation
import MobileCoreServices

class CameraViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @IBOutlet var cameraView: UIView!
  @IBOutlet var captureButton: UIButton!
  @IBOutlet var switchCameraButton: UIButton!
  @IBOutlet var flashButton: UIButton!
  @IBOutlet var galleryButton: UIButton!
  @IBOutlet var recordTimeLabel: UILabel!
  @IBOutlet var topView: UIView!
  @IBOutlet var bottomView: UIView!
  
  @IBOutlet var cameraViewTopConstraint: NSLayoutConstraint!
  @IBOutlet var cameraViewBottomConstraint: NSLayoutConstraint!
  
  let cameraManager = CameraManager()
  var story: Story?
  var recordTimer: NSTimer!
  var recordTime: Int = 0 {
    didSet {
      let second = recordTime % 60
      let minute = (recordTime - second) / 60
      
      recordTimeLabel.text = String (format: "%02d:%02d", arguments: [minute, second])
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleOrientationChange", name: UIDeviceOrientationDidChangeNotification, object: nil)
    self.navigationController?.navigationBar.hidden = true
    cameraManager.showAccessPermissionPopupAutomatically = true
    cameraManager.writeFilesToPhoneLibrary = false
    cameraManager.shouldRespondToOrientationChanges = false
    flashButton.enabled = cameraManager.hasFlash
    recordTimeLabel.hidden = true
    addCameraToView()
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    navigationController?.navigationBar.hidden = true
    cameraManager.resumeCaptureSession()
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    cameraManager.stopCaptureSession()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func handleCaptureButtonTap(sender: UIButton) {
    cameraManager.cameraOutputQuality = .High
    switch (cameraManager.cameraOutputMode) {
    case .StillImage:
      cameraManager.capturePictureWithCompletition({ (image, error) -> Void in
        self.performSegueWithIdentifier("photoPreview", sender: image)
      })
    case .VideoWithMic, .VideoOnly:
      cameraManager.stopRecordingVideo({ (videoURL, error) -> Void in
        if let errorOccured = error {
          self.cameraManager.showErrorBlock(erTitle: "Error occurred", erMessage: errorOccured.localizedDescription)
        }
        else {
          self.topView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
          self.bottomView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
          self.cameraViewTopConstraint.constant = 45
          self.cameraViewBottomConstraint.constant = 62
          self.cameraManager.cameraOutputMode = .StillImage
          self.performSegueWithIdentifier("videoEdit", sender: videoURL)
          self.recordTimer.invalidate()
          self.recordTimeLabel.text = "00:00"
        }
      })
    }
  }
  
  @IBAction func handleRecordButton(sender: UIButton) {
    cameraManager.cameraOutputMode = .VideoWithMic
    sender.selected = !sender.selected
    if sender.selected {
      cameraManager.startRecordingVideo()
      topView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
      bottomView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
      cameraViewTopConstraint.constant = 0
      cameraViewBottomConstraint.constant = 0
      recordTimeLabel.hidden = false
      recordTimer = NSTimer.every(1) {
        self.recordTime++
      }
    } else {
      cameraManager.stopRecordingVideo({ (videoURL, error) -> Void in
        if let errorOccured = error {
          self.cameraManager.showErrorBlock(erTitle: "Error occurred", erMessage: errorOccured.localizedDescription)
        }
        else {
          do {
            try NSFileHandle(forWritingToURL: videoURL!)
            print("success")
          } catch {
            print("error")
          }
          self.performSegueWithIdentifier("videoEdit", sender: videoURL)
          self.topView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
          self.bottomView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
          self.cameraViewTopConstraint.constant = 45
          self.cameraViewBottomConstraint.constant = 62
          self.cameraManager.cameraOutputMode = .StillImage
          self.recordTimer.invalidate()
          self.recordTime = 0
          self.recordTimeLabel.text = "00:00"
          self.recordTimeLabel.hidden = true
        }
      })
    }
  }
  
  @IBAction func handleSwitchCameraButtonTap(sender: UIButton) {
    
    cameraManager.cameraDevice = cameraManager.cameraDevice == CameraDevice.Front ? CameraDevice.Back : CameraDevice.Front
    switch (cameraManager.cameraDevice) {
    case .Front:
      sender.backgroundImageForState(.Normal)
      
    case .Back:
      sender.backgroundImageForState(.Normal)
    }
  }
  
  @IBAction func handleFlashButtonTap(sender: UIButton) {
    switch (cameraManager.changeFlashMode()) {
    case .Off:
      sender.setImage(UIImage(named: "flashOffIcon"), forState: .Normal)
      
    case .On:
      sender.setImage(UIImage(named: "flashOnIcon"), forState: .Normal)
      
    default:
      break
    }
  }
  
  private func addCameraToView() {
    cameraManager.addPreviewLayerToView(cameraView, newCameraOutputMode: CameraOutputMode.StillImage)
    cameraManager.showErrorBlock = { (erTitle: String, erMessage: String) -> Void in
    }
  }
  
  @IBAction func handleCancelButtonTap(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func handleGalleryButtonTap(sender: AnyObject) {
    let imagePicker = UIImagePickerController()
    
    imagePicker.delegate = self
    imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
    imagePicker.mediaTypes = [kUTTypeImage as String]
    imagePicker.allowsEditing = false
    
    self.presentViewController(imagePicker, animated: true,
      completion: nil)
  }

  func imagePickerControllerDidCancel(picker: UIImagePickerController) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    let mediaType = info[UIImagePickerControllerMediaType] as! NSString
    
    if mediaType.isEqualToString(kUTTypeImage as String) {
      let image = info[UIImagePickerControllerOriginalImage] as! UIImage
      print (image)
      dispatch_async(dispatch_get_main_queue(), {
        self.performSegueWithIdentifier("photoPreview", sender: image)
      })
      
    } else if mediaType.isEqualToString(kUTTypeMovie as String) {
      // TODO: What for?
      let url = info[UIImagePickerControllerMediaURL]
    }
    
    dismissViewControllerAnimated(true, completion: nil)
  }
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "photoPreview" {
      let photoEditViewController = segue.destinationViewController as! PhotoEditViewController
      photoEditViewController.image = sender as? UIImage
      photoEditViewController.story = story
    } else if segue.identifier == "videoEdit" {
      let nextVC = segue.destinationViewController as! VideoEditViewController
      nextVC.videoURL = (sender as? NSURL)!
    }
  }
  
  func handleOrientationChange() {
    var nextRotationAngle: CGFloat = 0
    
    switch UIDevice.currentDevice().orientation {
    case .LandscapeLeft:
      nextRotationAngle = CGFloat(M_PI_2)
      
    case .LandscapeRight:
      nextRotationAngle = -CGFloat(M_PI_2)
      
    default:
      break
    }
    
    UIView.animateWithDuration(0.2, animations: { () -> Void in
      let nextTransform = CGAffineTransformMakeRotation(nextRotationAngle)
      self.flashButton.transform = nextTransform
      self.switchCameraButton.transform = nextTransform
      self.galleryButton.transform = nextTransform
    })
  }
}

