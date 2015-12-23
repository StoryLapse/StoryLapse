//
//  PhotoViewController.swift
//  storylapse
//
//  Created by Khuong Pham on 12/8/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {
  
  @IBOutlet var navigationBar: UIBarButtonItem!
  @IBOutlet var collectionView: UICollectionView!
  
  var photos: [Photo] = []
  var story: Story! {
    didSet {
      title = story.title
      photos = Photo.getPhotos(getDatabase(), story: story)
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

    collectionView.backgroundColor = Colors.primaryBackgroundColor
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}

// MARK: Collection
extension StoryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return story.photoCount
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! PhotoCollectionViewCell
    cell.photoImageView.image = UIImage(named: photos[indexPath.row].localPath)
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
}

// MARK: Navigations
extension StoryViewController {
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "Detail",
      let cell = sender as? UICollectionViewCell,
      let indexPath = collectionView.indexPathForCell(cell),
      photoDetailVC = segue.destinationViewController as? PhotoDetailViewController  {
        
        photoDetailVC.selectedIndexPath = indexPath
        photoDetailVC.story = story
    }
  }
  
  // MARK: Handle Menu Button
  @IBAction func handleMenuButtonTap(sender: AnyObject) {
    
    
    let menuViewController = MenuViewController(items:
      [
        MenuViewItem(title: "Report", iconImage: UIImage(named: "warning-menu-icon")) {
          print("Reported")
        },
        MenuViewItem(title: "Delete", iconImage: UIImage(named: "garbage-bin-menu-icon")) {
          print("Deleted")
        },
        MenuViewItem(title: "Cancel", iconImage: UIImage(named: "cross-menu-icon"), type: .Cancel)
      ]
    )
    
    self.presentViewController(menuViewController, animated: true, completion: nil)
  }
  
  // MARK: Handle Share Button
  
  @IBAction func handleShareButtonTap(sender: AnyObject) {
    
    print("share")
    
    let myShare = "My lovely album! <3 <3"
    var imagesShared = [UIImage]()
    for index in 0..<story.photoCount {
      let image = UIImage(named: photos[index].localPath)
      imagesShared.append(image!)
    }
    
    let shareVC: UIActivityViewController = UIActivityViewController(activityItems: [imagesShared, myShare], applicationActivities: nil)
    self.presentViewController(shareVC, animated: true, completion: nil)
  }
}