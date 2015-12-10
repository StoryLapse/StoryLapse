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

    var selectedImage : UIImage!

    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var numberOfLoveFace: UILabel!
    @IBOutlet var numberOfLove: UILabel!
    @IBOutlet var numberOfKiss: UILabel!
    @IBOutlet var loveImageView: UIImageView!
    @IBOutlet var kissImageView: UIImageView!
    @IBOutlet var loveFaceImageView: UIImageView!
    @IBOutlet var numberOfPunch: UILabel!
    @IBOutlet var punchImageView: UIImageView!
    @IBOutlet var timeTakenLabel: UILabel!

    override func viewDidLoad() {
        title = "Photo Detail"
        super.viewDidLoad()
        //photoImageView.image = selectedImage
        photoImageView.image = UIImage(named: "16")
    }

    @IBAction func onBackClicked(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
