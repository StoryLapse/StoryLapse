//
//  PhotoViewController.swift
//  storylapse
//
//  Created by Khuong Pham on 12/8/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit
import FXImageView

class PhotoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {


    @IBOutlet var navigationBar: UIBarButtonItem!
    @IBOutlet var collectionView: UICollectionView!
    var images = [String]()

    override func viewDidLoad() {

        super.viewDidLoad()
        title = "Story??"
        navigationController!.navigationBar.barTintColor = UIColor(red: 82/255, green: 173/255, blue: 243/255, alpha: 1.0)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

//        images = NSMutableArray(array: ["1","2","3","4","5","6","7","8","9","10", "1","2","3","4","5","6","7","8","9","10", "1","2","3","4","5","6","7","8","9","10"])
        images = ["11", "12", "13", "14", "15", "16", "17", "18", "11", "12", "13", "14", "15", "16", "17", "18", "11", "12", "13", "14", "15", "16", "17", "18"]
        self.navigationBar.image = UIImage(named: "share")?.imageWithRenderingMode(.AlwaysOriginal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Collection
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! PhotoCollectionViewCell
        cell.photoImageView.image = UIImage(named: images[indexPath.row])
        cell.photoImageView.alpha = 0

        let millisecondDelay = UInt64(arc4random() % 600) / 1000

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(millisecondDelay * NSEC_PER_SEC)), dispatch_get_main_queue(),({ () -> Void in

            UIView.animateWithDuration(0.5, animations: ({
                cell.photoImageView.alpha = 1.0
            }))
        }))
        return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3 - 1.5, height: collectionView.frame.width/3 - 1)
    }

    func collectionView(collection: UICollectionView, selectedItemIndex: NSIndexPath) {
        self.performSegueWithIdentifier("Detail", sender: self)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "Detail" {
            let indexPaths = self.collectionView.indexPathsForSelectedItems()!
            let indexPath = indexPaths[0] as NSIndexPath
            let photoDetailVC = segue.destinationViewController as! PhotoDetailViewController

            photoDetailVC.photoImage = UIImage(named: images[indexPath.row])!
        }
    }

    @IBAction func onShareTouched(sender: AnyObject) {

    }
    
    
}
