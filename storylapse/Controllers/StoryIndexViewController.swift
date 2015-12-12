//
//  StoryIndexViewController.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/8/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class StoryIndexViewController: UIViewController {
  
  @IBOutlet var noStoryIndicatorView: UIView!
  @IBOutlet var storyTableView: UITableView!
  
  var stories: [Story]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "YOUR STORIES"
    navigationController?.title = nil
    
    initializeObservation()
  }
}

extension StoryIndexViewController {
  
  func initializeObservation() {
    let query = getDatabase().viewNamed("currentUserStories").createQuery()
    let results = try! query.run()
    let stories = results.map { row in
      Story(forDocument: row.document!!)
    }
    
    print(stories.map { $0.title })
  }
}