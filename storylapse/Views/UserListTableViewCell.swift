//
//  UserListTableViewCell.swift
//  storylapse
//
//  Created by Khuong Pham on 12/20/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class UserListTableViewCell: UITableViewCell {

  @IBOutlet var userAvatarImageView: UIImageView!
  @IBOutlet var userNameLabel: UILabel!
  @IBOutlet var typeInteractionImageView: UIImageView!
  @IBOutlet var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
