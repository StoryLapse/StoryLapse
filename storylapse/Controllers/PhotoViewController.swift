//
//  PhotoViewController.swift
//  storylapse
//
//  Created by Khuong Pham on 12/8/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

//public var images = ["11", "12", "13", "14", "15", "16", "17", "18", "11", "12", "13", "14", "15", "16", "17", "18", "11", "12", "13", "14", "15", "16", "17", "18"]
//public var imagePath = "/Users/entropy/Library/Developer/CoreSimulator/Devices/FCF08D6E-B837-4F3B-AC99-758936769A5A/data/Containers/Data/Application/CF4CA6CB-CADA-4E6E-8E31-FF0FD464EA7B/Documents/photos/m1.jpeg"
//public var images = [fileInDocumentsDirectory("m1.jpeg"), fileInDocumentsDirectory("m2.jpeg"), fileInDocumentsDirectory("m3.jpeg")]
public var images = [fileInDocumentsDirectory("D8B07964-E499-465F-8221-AAB24659430E.png"), fileInDocumentsDirectory("m1.jpeg"), fileInDocumentsDirectory("m2.jpeg"), fileInDocumentsDirectory("m3.jpeg")]

class PhotoViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {


  @IBOutlet var navigationBar: UIBarButtonItem!
  @IBOutlet var collectionView: UICollectionView!

  var imagesStringArray = [String]()
  //    var images = [String]()

  override func viewDidLoad() {

    super.viewDidLoad()
    title = "Story??"
    navigationController!.navigationBar.barTintColor = UIColor(red: 82/255, green: 173/255, blue: 243/255, alpha: 1.0)
    navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]


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
    //cell.photoImageView.image = images[indexPath.row]
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
    return CGSize(width: collectionView.frame.width/3 , height: collectionView.frame.width/3 )
  }

  func collectionView(collection: UICollectionView, selectedItemIndex: NSIndexPath) {
    self.performSegueWithIdentifier("Detail", sender: self)
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    if segue.identifier == "Detail",
      let cell = sender as? UICollectionViewCell,
      let indexPath = collectionView.indexPathForCell(cell),
      photoDetailVC = segue.destinationViewController as? PhotoDetailViewController  {

      photoDetailVC.selectedIndexPath = indexPath
    }
  }

  @IBAction func onShareTouched(sender: AnyObject) {

  }

  // MARK: load image from path file

  func loadImageFromPath(path: String) -> UIImage? {

    let image = UIImage(contentsOfFile: path)

    if image == nil {

      print("missing image at: \(path)")
    }
    print("Loading image from path: \(path)") // this is just for you to see the path in case you want to go to the directory, using Finder.
    return image

  }


}
