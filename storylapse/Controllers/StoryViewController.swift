//
//  PhotoViewController.swift
//  storylapse
//
//  Created by Khuong Pham on 12/8/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

var images = [String]()

class StoryViewController: UIViewController {


  @IBOutlet var optionMenuView: MenuOptionsView!
  @IBOutlet var navigationBar: UIBarButtonItem!
  @IBOutlet var collectionView: UICollectionView!
  
  var photos: [Photo] = []
  var story: Story! {
    didSet {
      photos = Photo.getPhotos(getDatabase(), story: story)
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Dalat trip"
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    let screenSize: CGRect = UIScreen.mainScreen().bounds
    optionMenuView = MenuOptionsView.init(frame: CGRect(x: screenSize.width - optionMenuView.frame.width, y: 0, width: optionMenuView.frame.width, height: optionMenuView.frame.height))
    view.addSubview(optionMenuView)
    optionMenuView.hidden = true
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
    }
  }

// MARK: Handle Menu Button
  @IBAction func handleMenuButtonTap(sender: AnyObject) {

    if optionMenuView.hidden == false {
      optionMenuView.hidden = true
    } else {
      optionMenuView.hidden = false
    }
    
  }

}