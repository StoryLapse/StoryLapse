//
//  PhotoViewController.swift
//  storylapse
//
//  Created by Khuong Pham on 12/8/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit
import iCarousel

class PhotoViewController: UIViewController, iCarouselDataSource, iCarouselDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {


    @IBOutlet var navigationBar: UIBarButtonItem!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var viewCarousel: iCarousel!
    var images : NSMutableArray = NSMutableArray()

    override func viewDidLoad() {

        super.viewDidLoad()
        title = "Story??"
        navigationController!.navigationBar.barTintColor = UIColor(red: 82/255, green: 173/255, blue: 243/255, alpha: 1.0)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

//        images = NSMutableArray(array: ["1","2","3","4","5","6","7","8","9","10", "1","2","3","4","5","6","7","8","9","10", "1","2","3","4","5","6","7","8","9","10"])
        images = NSMutableArray(array: ["11", "12", "13", "14", "15", "16", "17", "18", "11", "12", "13", "14", "15", "16", "17", "18", "11", "12", "13", "14", "15", "16", "17", "18"])
        viewCarousel.type = iCarouselType.Cylinder
        viewCarousel.reloadData()
        self.navigationBar.image = UIImage(named: "photomenu")?.imageWithRenderingMode(.AlwaysOriginal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: icarousel delegate methods

    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
        return images.count
    }

    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView {
        var itemView: UIImageView
        if (view == nil) {
            itemView = UIImageView(frame:CGRect(x:0, y:0, width:250, height:350))
            itemView.contentMode = .ScaleAspectFit
            viewCarousel.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        }
        else {
            itemView = view as! UIImageView;
        }
        itemView.image = UIImage(named: "\(images.objectAtIndex(index))")
        return itemView
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
        cell.photoImageView.image = UIImage(named: images[indexPath.row] as! String)
        return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/3 - 5, height: collectionView.frame.width/3 - 5)
    }

    @IBAction func switchTypeWatchTouch(sender: AnyObject) {
        UIView.animateWithDuration(1.0) { () -> Void in
            if self.collectionView.alpha == 1.0 {
                self.viewCarousel.alpha = 1.0
                self.collectionView.alpha = 0.0
                self.navigationBar.image = UIImage(named: "collectionmenu")?.imageWithRenderingMode(.AlwaysOriginal)
            } else if self.viewCarousel.alpha == 1.0 {
                self.collectionView.alpha = 1.0
                self.viewCarousel.alpha = 0.0
                self.navigationBar.image = UIImage(named: "photomenu")?.imageWithRenderingMode(.AlwaysOriginal)
            }
        }

    }
}
