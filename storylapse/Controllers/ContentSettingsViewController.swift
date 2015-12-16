//
//  ContentSettingsViewController.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/15/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class ContentSettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var image: UIImage?
    var story: Story?
    @IBOutlet var imagePreviewView: UIImageView!
    @IBOutlet var tableView: UITableView!
    var stories : [Story]!
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationController?.navigationBar.hidden = false
    title = "Settings"
    if let validImage = self.image {
        self.imagePreviewView.image = validImage
    }
    tableView.delegate = self
    tableView.dataSource = self
    stories = Story.getCurrentUserStories(getDatabase())
  }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if stories != nil {
            return stories.count
        } else {
            return 0
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("recentStories") as! SettingPhotoTableViewCell
        cell.story = stories[indexPath.row]
        return cell
    }
}
