//
//  ImageConfirmViewController.swift
//  storylapse
//
//  Created by huy ngo on 12/15/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class PhotoEditViewController: UIViewController {
  
  var image: UIImage?
  var story: Story?
  
  @IBOutlet var imagePreviewView: UIImageView!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.navigationBar.hidden = true
    if let validImage = self.image {
      self.imagePreviewView.image = validImage
    }
  }
  
  @IBAction func onCancleButton(sender: AnyObject) {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func onDoneButton(sender: AnyObject) {
    let photo = Photo.create(getDatabase())
    if let image = imagePreviewView.image {
      saveImage(image, path: photo.localPath)
    }
  }
  
  func saveImage(image: UIImage, path: String ) -> Bool {
    let pngImageData = UIImageJPEGRepresentation(image, 1)
    let result = pngImageData!.writeToFile(path, atomically: true)
    return result
  }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showPhotoAddSegue" {
            let nextVC = segue.destinationViewController as! PhotoAddViewController
            nextVC.image = image
        }
    }
}
