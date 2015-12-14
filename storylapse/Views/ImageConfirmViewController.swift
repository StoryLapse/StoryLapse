//
//  ImageConfirmViewController.swift
//  storylapse
//
//  Created by huy ngo on 12/15/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

func getDocumentsURL() -> NSURL {
    let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
    let folderphotosURL = documentsURL.URLByAppendingPathComponent("photos")
    do {
        try NSFileManager.defaultManager().createDirectoryAtPath(folderphotosURL.path!, withIntermediateDirectories: true, attributes: nil)
    } catch let error as NSError {
        NSLog("Unable to create directory \(error.debugDescription)")
    }
    return folderphotosURL
}

func fileInDocumentsDirectory(filename: String) -> String {
    let fileURL = getDocumentsURL().URLByAppendingPathComponent(filename)
    return fileURL.path!
    
}

class ImageConfirmViewController: UIViewController {
    
    var image: UIImage?
    @IBOutlet var imagePreviewView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = false
        if let validImage = self.image {
            self.imagePreviewView.image = validImage
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancleButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func onDoneButton(sender: AnyObject) {
        let uuid = NSUUID().UUIDString
        let type = ".png"
        // uuid.stringByAppendingString(type)
        print("UUID string: \(uuid)") // UUID string: 76A4073A-D79C-45FD-A5D6-86E52AD8C771
        let myImageName = uuid.stringByAppendingString(type)
        let imagePath = fileInDocumentsDirectory(myImageName)
        if let image = imagePreviewView.image {
            saveImage(image, path: imagePath)
            print(imagePath)
        } else { print("some error message") }
    }
    
    func saveImage (image: UIImage, path: String ) -> Bool{
        let pngImageData = UIImagePNGRepresentation(image)
        //let jpgImageData = UIImageJPEGRepresentation(image, 1.0)   // if you want to save as JPEG
        let result = pngImageData!.writeToFile(path, atomically: true)
        return result
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
