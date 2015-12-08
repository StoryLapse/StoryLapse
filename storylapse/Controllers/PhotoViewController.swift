//
//  PhotoViewController.swift
//  storylapse
//
//  Created by Khuong Pham on 12/8/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit
import iCarousel

class PhotoViewController: UIViewController, iCarouselDataSource, iCarouselDelegate {
    
    @IBOutlet var viewCarousel: iCarousel!
    var images : NSMutableArray = NSMutableArray()

    override func viewDidLoad() {

        super.viewDidLoad()

        images = NSMutableArray(array: ["1.jpg","2.jpg","3","4","5","6","7","8","9","10"])
        viewCarousel.type = iCarouselType.Cylinder
        viewCarousel.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: icarousel delegate methods

    func numberOfItemsInCarousel(carousel: iCarousel) -> Int {
        return images.count
    }

    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView {
        var itemView: UIImageView
        if (view == nil)
        {
            itemView = UIImageView(frame:CGRect(x:0, y:0, width:250, height:250))
            itemView.contentMode = .ScaleAspectFit
        }
        else
        {
            itemView = view as! UIImageView;
        }
        itemView.image = UIImage(named: "\(images.objectAtIndex(index))")
        return itemView
    }

}
