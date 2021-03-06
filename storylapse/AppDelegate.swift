//
//  AppDelegate.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/6/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit
import OAuthSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  var database: CBLDatabase!
  
  var pull: CBLReplication!
  var push: CBLReplication!
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    initializePhotoDir()
    initializeDatabase()
    User.initializeCurrentUser(getDatabase())
    
    window?.tintColor = Colors.tintColor

    application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Sound, .Badge, .Alert], categories: nil))
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
  
  func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
    if (url.host == "oauth-callback") {
      OAuth2Swift.handleOpenURL(url)
    }
    return true
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

// MARK: Database
extension AppDelegate {
  
  func initializeDatabase() {
    let manager = CBLManager.sharedInstance()
    database = try! manager.databaseNamed("storylapse")
    
    Story.createViews(database)
    
    let url = NSURL(string: "http://localhost:4984/storylapse/")!
    push = database.createPushReplication(url)!
    pull = database.createPullReplication(url)!
    push.continuous = true
    pull.continuous = true
    
    let auth = CBLAuthenticator.basicAuthenticatorWithName("firstUser", password: "123")
    push.authenticator = auth
    pull.authenticator = auth

//    push.start()
//    pull.start()
    
    NSNotificationCenter.defaultCenter().addObserver(self,
      selector: "replicationChanged:",
      name: kCBLReplicationChangeNotification,
      object: push)
    NSNotificationCenter.defaultCenter().addObserver(self,
      selector: "replicationChanged:",
      name: kCBLReplicationChangeNotification,
      object: pull)
  }
  
  func replicationChanged(n: NSNotification) {
  }
}