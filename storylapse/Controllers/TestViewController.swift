//
//  TestViewController.swift
//  storylapse
//
//  Created by huy ngo on 12/17/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit
import ImageIO
import MobileCoreServices
class TestViewController: UIViewController {
    
    @IBOutlet var gifImageView: UIImageView!
    var gifImages: [UIImage] = []
    var photos: [Photo] = []
    var stories: [Story]!
    var index = 0
    var story: Story! {
        didSet {
            photos = Photo.getPhotos(getDatabase(), story: story)
        }
    }

    @IBOutlet var storyImageView: ImageStoryView!
    override func viewDidLoad() {
        super.viewDidLoad()
        stories = Story.getCurrentUserStories(getDatabase())
        story = stories[0]
        photos = Photo.getPhotos(getDatabase(), story: story)
        storyImageView = ImageStoryView(frame: CGRectMake(0, 50, view.bounds.width, 200))
        storyImageView.image = UIImage(named: photos[0].localPath)
        var timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "ChangeImage", userInfo: nil, repeats: true)
        //storyImageView.image = UIImage(named: photos[0].localPath)
       // storyImageView.caption = "caption"
        
        /*for photo in photos {
        storyImageView.image = UIImage(named: photo.localPath)
        } */
        // Do any additional setup after loading the view.
        for i in 0..<3 {
        gifImages.append(UIImage(named: photos[i].localPath)!)
        }
        createGIF(with: gifImages, frameDelay: 1.0) { (data, error) -> () in
            print("error: \(error)")
        }
    }
    func ChangeImage()
    {
        UIView.animateWithDuration(4, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            self.storyImageView.image = UIImage(named: self.photos[self.index].localPath)
            self.storyImageView.alpha = 0.1
            self.index++
            }) { (finish) -> Void in
                    UIView.animateWithDuration(3, animations: { () -> Void in
                        self.storyImageView.image = UIImage(named: self.photos[self.index].localPath)
                        self.storyImageView.alpha = 1
                    })
            //self.storyImageView.alpha = 1.0
        }
       // storyImageView.image = UIImage(named: photos[index].localPath)
       // index++
        print(index)
        view.addSubview(storyImageView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */ 
    func createGIF(with images: [UIImage], loopCount: Int = 0, frameDelay: Double, callback: (data: NSData?, error: NSError?) -> ()) {
        let fileProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFLoopCount as String: loopCount]]
        let frameProperties = [kCGImagePropertyGIFDictionary as String: [kCGImagePropertyGIFDelayTime as String: frameDelay]]
        
        let documentsDirectory = NSTemporaryDirectory()
        let url = NSURL(fileURLWithPath: documentsDirectory).URLByAppendingPathComponent("animated.gif")
            print(url)
            let destination = CGImageDestinationCreateWithURL(url, kUTTypeGIF, images.count, nil)
            CGImageDestinationSetProperties(destination!, fileProperties)
            
            for i in 0..<images.count {
                CGImageDestinationAddImage(destination!, images[i].CGImage!, frameProperties)
            }
            
            if CGImageDestinationFinalize(destination!) {
                callback(data: NSData(contentsOfURL: url), error: nil)
            } else {
                callback(data: nil, error: nil)
            }
        
    }
}
