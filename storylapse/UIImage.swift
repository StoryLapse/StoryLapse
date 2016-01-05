//
//  UIImage.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 1/5/16.
//  Copyright © 2016 Lê Quang Bửu. All rights reserved.
//

import UIKit

extension UIImage {
  public func imageRotatedByDegrees(degrees: CGFloat, flip: Bool) -> UIImage {
    let degreesToRadians: (CGFloat) -> CGFloat = {
      return $0 / 180.0 * CGFloat(M_PI)
    }
    
    // calculate the size of the rotated view's containing box for our drawing space
    let nextFrame = degrees == 90 || degrees == -90 ?
    CGRect(origin: CGPointZero, size: size) :
    CGRect(origin: CGPointZero, size: CGSizeMake(size.height, size.width))
    let rotatedViewBox = UIView(frame: nextFrame)
    let t = CGAffineTransformMakeRotation(degreesToRadians(degrees));
    rotatedViewBox.transform = t
    let rotatedSize = rotatedViewBox.frame.size
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize)
    let bitmap = UIGraphicsGetCurrentContext()
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width / 2.0, rotatedSize.height / 2.0);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, degreesToRadians(degrees));
    
    // Now, draw the rotated/scaled image into the context
    var yFlip: CGFloat
    
    if(flip){
      yFlip = CGFloat(-1.0)
    } else {
      yFlip = CGFloat(1.0)
    }
    
    CGContextScaleCTM(bitmap, yFlip, -1.0)
    CGContextDrawImage(bitmap, CGRectMake(-size.width / 2, -size.height / 2, size.width, size.height), CGImage)
    
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
  }
  
  public func imageByAutoOrientation() -> UIImage {
    switch imageOrientation {
    case .Down:
      return imageRotatedByDegrees(180, flip: false)
      
    case .Left:
      return imageRotatedByDegrees(90, flip: false)
      
    case .Right:
      return imageRotatedByDegrees(-90, flip: false)
    
    default:
      return self
    }
  }
}

