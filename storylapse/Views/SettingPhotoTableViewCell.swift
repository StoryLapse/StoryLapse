//
//  SettingPhotoTableViewCell.swift
//  storylapse
//
//  Created by huy ngo on 12/16/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class SettingPhotoTableViewCell: UITableViewCell {

    @IBOutlet var storiesLabel: UILabel!
    var story : Story! {
        didSet {
            storiesLabel.text = story.title
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
