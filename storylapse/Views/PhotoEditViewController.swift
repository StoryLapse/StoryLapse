//
//  ImageConfirmViewController.swift
//  storylapse
//
//  Created by huy ngo on 12/15/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class PhotoEditViewController: UIViewController {
  
  @IBOutlet var imagePreviewView: UIImageView!
  
  var image: UIImage?
  var story: Story?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Preview"
    navigationController?.navigationBar.hidden = false
    view.backgroundColor = Colors.primaryBackgroundColor
    
    imagePreviewView.backgroundColor = Colors.primaryBackgroundColor
    imagePreviewView.image = image
  }
  
  @IBAction func onDoneButton(sender: AnyObject) {
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showPhotoAddSegue" {
      let nextVC = segue.destinationViewController as! PhotoAddViewController
      nextVC.image = image
    }
  }
}
