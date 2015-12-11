//
//  PhotoDetailViewController.swift
//  storylapse
//
//  Created by Khuong Pham on 12/10/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import Foundation
import UIKit

class PhotoDetailViewController: UIViewController {

    
    @IBOutlet var photoImageView: UIImageView!
    var photoImage = UIImage()

    override func viewDidLoad() {
        
        title = "Photo Detail"
        super.viewDidLoad()
        photoImageView.image = photoImage
    }

    @IBAction func onBackClicked(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
