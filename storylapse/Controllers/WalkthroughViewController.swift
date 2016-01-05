//
//  WalkthroughViewController.swift
//  storylapse
//
//  Created by Khuong Pham on 1/6/16.
//  Copyright © 2016 Lê Quang Bửu. All rights reserved.
//


import UIKit

class WalkthroughViewController: UIViewController, BWWalkthroughViewControllerDelegate {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
      showWalkthrough()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  @IBAction func showWalkthrough() {

    // Get view controllers and build the walkthrough
    let stb = UIStoryboard(name: "Walkthrough", bundle: nil)
    let walkthrough = stb.instantiateViewControllerWithIdentifier("walk") as! BWWalkthroughViewController
    let page_zero = stb.instantiateViewControllerWithIdentifier("walk0")
    let page_one = stb.instantiateViewControllerWithIdentifier("walk1")
    let page_two = stb.instantiateViewControllerWithIdentifier("walk2")
    let page_three = stb.instantiateViewControllerWithIdentifier("walk3")

    // Attach the pages to the master
    walkthrough.delegate = self
    walkthrough.addViewController(page_one)
    walkthrough.addViewController(page_two)
    walkthrough.addViewController(page_three)
    walkthrough.addViewController(page_zero)

    self.presentViewController(walkthrough, animated: true, completion: nil)
  }


  // MARK: - Walkthrough delegate -

  func walkthroughPageDidChange(pageNumber: Int) {
    print("Current Page \(pageNumber)")
  }

  func walkthroughCloseButtonPressed() {
    dismissViewControllerAnimated(true, completion: nil)
    performSegueWithIdentifier("goToMainView", sender: self)
  }

}