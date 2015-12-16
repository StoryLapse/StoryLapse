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
  
  let cameraManager = CameraManager()
  var story: Story?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    cameraManager.showAccessPermissionPopupAutomatically = true
    flashButton.enabled = cameraManager.hasFlash
    
    addCameraToView()
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
  
  @IBAction func onCaptureButton(sender: UIButton) {
    cameraManager.cameraOutputQuality = .High
    cameraManager.cameraOutputMode = .StillImage
    switch (cameraManager.cameraOutputMode) {
    case .StillImage:
      cameraManager.capturePictureWithCompletition({ (image, error) -> Void in
        self.performSegueWithIdentifier("imageView", sender: image)
      })
    case .VideoWithMic, .VideoOnly:
      sender.selected = !sender.selected
      sender.setTitle(" ", forState: UIControlState.Selected)
      sender.backgroundColor = sender.selected ? UIColor.redColor() : UIColor.greenColor()
      if sender.selected {
        cameraManager.startRecordingVideo()
      } else {
        cameraManager.stopRecordingVideo({ (videoURL, error) -> Void in
          if let errorOccured = error {
            self.cameraManager.showErrorBlock(erTitle: "Error occurred", erMessage: errorOccured.localizedDescription)
          }
        })
      }
    }
    
  }
  
  @IBAction func onSwitchCameraButton(sender: UIButton) {
    
    cameraManager.cameraDevice = cameraManager.cameraDevice == CameraDevice.Front ? CameraDevice.Back : CameraDevice.Front
    switch (cameraManager.cameraDevice) {
    case .Front:
      sender.backgroundImageForState(.Normal)
      
    case .Back:
      sender.backgroundImageForState(.Normal)
    }
  }
  
  @IBAction func onFlashButton(sender: UIButton) {
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
    cameraManager.addPreviewLayerToView(cameraView, newCameraOutputMode: CameraOutputMode.VideoWithMic)
    cameraManager.showErrorBlock = { (erTitle: String, erMessage: String) -> Void in
    }
  }
  
  @IBAction func onGalleryButton(sender: AnyObject) {
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
      
      dispatch_async(dispatch_get_main_queue(), {
        self.performSegueWithIdentifier("imageView", sender: image)
      })
      
    } else if mediaType.isEqualToString(kUTTypeMovie as String) {
      // TODO: What for?
      let url = info[UIImagePickerControllerMediaURL]
    }
    
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // TODO: Check segue.identifier to prevent futhur error
    let nextVC = segue.destinationViewController as! PhotoEditViewController
    nextVC.image = sender as? UIImage
  }
}
