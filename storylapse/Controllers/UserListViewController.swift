//
//  UserListViewController.swift
//  storylapse
//
//  Created by Khuong Pham on 12/20/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class UserListViewController: UITableViewController {


  @IBOutlet var userListTableView: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    userListTableView.delegate = self
    userListTableView.dataSource = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  // MARK: - Table view data source

  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return 20
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

    let cell = tableView.dequeueReusableCellWithIdentifier("UserListCell", forIndexPath: indexPath) as! UserListTableViewCell
    cell.userAvatarImageView.image = UIImage(named: "person")
    cell.userNameLabel.text = "Khuong"
    cell.timeLabel.text = "Thu, Dec-24-12:56 PM"
    cell.typeInteractionImageView.image = UIImage(named: "loveface")
    cell.layer.borderWidth = 0.5
    cell.layer.borderColor = UIColor.blueColor().CGColor

    return cell
  }

  // MARK: - Navigation

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
  }

}
