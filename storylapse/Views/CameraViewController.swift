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
import AssetsLibrary
import KYShutterButton
class CameraViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  
  @IBOutlet var focusGestureRecognizer: UITapGestureRecognizer!
  
  @IBOutlet var cameraView: UIView!
  @IBOutlet var captureButton: UIButton!
  @IBOutlet var switchCameraButton: UIButton!
  @IBOutlet var flashButton: UIButton!
  @IBOutlet var galleryButton: UIButton!
  @IBOutlet var recordTimeLabel: UILabel!
  @IBOutlet var topView: UIView!
  @IBOutlet var bottomView: UIView!
  var currentframe: CGRect?
  @IBOutlet var recordButton: KYShutterButton!
  
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
    flashButton.enabled = cameraManager.hasFlash
    recordTimeLabel.hidden = true
    addCameraToView()
    currentframe = topView.frame
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
        if let image = image {
          self.performSegueWithIdentifier("photoPreview", sender: image)
        }
      })
    case .VideoWithMic, .VideoOnly:
      cameraManager.stopRecordingVideo({ (videoURL, error) -> Void in
        self.recordButton.buttonState = .Normal
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
      recordButton.buttonState = .Recording
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
        self.recordButton.buttonState = .Normal
        if let errorOccured = error {
          self.cameraManager.showErrorBlock(erTitle: "Error occurred", erMessage: errorOccured.localizedDescription)
        }
        else {
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
      
    case .Portrait:
      nextRotationAngle = 0
      
    default:
      break
    }
    
    let cameraViewOriginFrame = cameraView.frame
    cameraView.transform = CGAffineTransformMakeRotation(nextRotationAngle)
    cameraView.frame = cameraViewOriginFrame
    
    UIView.animateWithDuration(0.2, animations: { () -> Void in
      let nextTransform = CGAffineTransformMakeRotation(nextRotationAngle)
      if self.cameraManager.cameraOutputMode == .StillImage {
        self.flashButton.transform = nextTransform
        self.switchCameraButton.transform = nextTransform
        self.galleryButton.transform = nextTransform
        
      } else if self.cameraManager.cameraOutputMode == .VideoWithMic {
        switch UIDevice.currentDevice().orientation {
        case .Portrait:
          self.topView.transform = CGAffineTransformMakeRotation(nextRotationAngle)
          self.topView.frame = self.currentframe!
        case .LandscapeLeft:
          self.topView.transform = nextTransform
          self.topView.frame = CGRect(x: self.view.frame.width - self.topView.frame.width , y: (self.view.frame.height)/2 - self.topView.frame.height/2, width: self.topView.frame.width, height: self.topView.frame.height)
        case .LandscapeRight:
          self.topView.transform = nextTransform
          self.topView.frame = CGRect(x: 0 , y: (self.view.frame.height)/2 - self.topView.frame.height/2, width: self.topView.frame.width, height: self.topView.frame.height)
        default:
          break
        }
      }
    })
  }
  
  @IBAction func handeTapFocusGesture(sender: UIGestureRecognizer) {
    let focusPoint = focusGestureRecognizer.locationInView(cameraView)
    //cameraManager.setFocusMode(AVCaptureFocusMode.ContinuousAutoFocus, atPoint: focusPoint)
    //cameraManager.setExposureMode(AVCaptureExposureMode.ContinuousAutoExposure, atPoint: focusPoint)
  }
}

