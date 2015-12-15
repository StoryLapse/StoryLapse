//
//  PhotoViewController.swift
//  storylapse
//
//  Created by Khuong Pham on 12/8/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

public var images = [fileInDocumentsDirectory("D8B07964-E499-465F-8221-AAB24659430E.png"), fileInDocumentsDirectory("m1.jpeg"), fileInDocumentsDirectory("m2.jpeg"), fileInDocumentsDirectory("m3.jpeg")]

class StoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {


  @IBOutlet var navigationBar: UIBarButtonItem!
  @IBOutlet var collectionView: UICollectionView!

  var imagesStringArray = [String]()

  override func viewDidLoad() {

    super.viewDidLoad()
    title = "Dalat trip"
    self.navigationBar.image = UIImage(named: "share")
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
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
    return CGSize(width: collectionView.frame.width/3 , height: collectionView.frame.width/3 )
  }

  override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {
    super.traitCollectionDidChange(previousTraitCollection)

    collectionView.reloadData()
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


}
