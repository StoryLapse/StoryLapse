//
//  AppDelegate.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/6/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var database: CBLDatabase!
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    
    initializePhotoDir()
    //resetFixtures()
    initializeDatabase()
    
    window?.tintColor = Colors.tintColor
    return true
  }
  
  func initializePhotoDir() {
    let photoDirURL = Photo.getPhotoDirURL()
    
    do {
      try NSFileManager.defaultManager().createDirectoryAtPath(photoDirURL.path!, withIntermediateDirectories: true, attributes: nil)
      
    } catch let error as NSError {
      NSLog("Unable to create directory \(error.debugDescription)")
    }
  }
  
  func initializeDatabase() {
    let manager = CBLManager.sharedInstance()
    database = try! manager.databaseNamed("storylapse")
    
    Story.createViews(database)
  }
  
  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }
  
  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }
  
  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }
  
  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
}

func getDatabase() -> CBLDatabase {
  return (UIApplication.sharedApplication().delegate as! AppDelegate).database
}

