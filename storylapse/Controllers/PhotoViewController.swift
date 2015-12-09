//
//  PhotoViewController.swift
//  storylapse
//
//  Created by Khuong Pham on 12/8/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit
import iCarousel
import FXImageView

class PhotoViewController: UIViewController, iCarouselDataSource, iCarouselDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {


    @IBOutlet var navigationBar: UIBarButtonItem!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var viewCarousel: iCarousel!
    var images = [String]()

    override func viewDidLoad() {

        super.viewDidLoad()
        title = "Story??"
        navigationController!.navigationBar.barTintColor = UIColor(red: 82/255, green: 173/255, blue: 243/255, alpha: 1.0)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]

//        images = NSMutableArray(array: ["1","2","3","4","5","6","7","8","9","10", "1","2","3","4","5","6","7","8","9","10", "1","2","3","4","5","6","7","8","9","10"])
        images = ["11", "12", "13", "14", "15", "16", "17", "18", "11", "12", "13", "14", "15", "16", "17", "18", "11", "12", "13", "14", "15", "16", "17", "18"]
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

            let imageView = FXImageView(frame: CGRect(x: 0.0, y: 355, width: 235, height: 30))
            imageView.reflectionScale = 1.0
            imageView.reflectionAlpha = 0.9
            imageView.reflectionGap = 2.0
            imageView.alpha = 0.25
            imageView.shadowOffset = CGSizeMake(0, 0)
            imageView.shadowBlur = 0.0
            imageView.cornerRadius = 1.0

            itemView.addSubview(imageView)
        } else {
            itemView = view as! UIImageView
        }

        let image = UIImage(named: images[index])

        if let imageView = view?.subviews.first as? FXImageView {
            imageView.image = image
        }


        itemView.image = image

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
