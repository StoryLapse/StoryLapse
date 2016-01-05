//
//  File.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 1/1/16.
//  Copyright © 2016 Lê Quang Bửu. All rights reserved.
//

import UIKit
import Cartography

class StoryHeaderView: UIView {
  
  @IBOutlet var creatorAvatarImageView: UIImageView!
  @IBOutlet var creatorNameLabel: UILabel!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet private var view: UIView!
  
  var story: Story! {
    didSet {
      creatorAvatarImageView.af_setImageWithURL(NSURL(string: story.creatorAvatarPath)!)
      creatorAvatarImageView.layer.cornerRadius = 2
      creatorAvatarImageView.clipsToBounds = true
      
      creatorNameLabel.text = story.creatorName
      titleLabel.text = story.title
      
      print(view.bounds)
      view.autoresizingMask = .FlexibleHeight
      view.layoutIfNeeded()
      print(view.bounds)
      self.layoutIfNeeded()
      print(self.bounds)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initSubViews()
  }
  
  required override init(frame: CGRect) {
    super.init(frame: frame)
    initSubViews()
  }
  
  func initSubViews() {
    let nib = UINib(nibName: "StoryHeaderView", bundle: nil)
    nib.instantiateWithOwner(self, options: nil)
    
    addSubview(view)
    
    constrain(view, self) { view, mainView in
      view.top == mainView.top
      view.right == mainView.right
      view.left == mainView.left
    }
    
    creatorNameLabel.textColor = Colors.primaryTextColor
    titleLabel.textColor = Colors.primaryTextColor
  }
}
