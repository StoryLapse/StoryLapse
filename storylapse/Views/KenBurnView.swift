//
//  KenBurnView.swift
//  storylapse
//
//  Created by Khuong Pham on 12/18/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit
import JBKenBurnsView

class KenBurnView: JBKenBurnsView {

  @IBOutlet var kenBurnView: JBKenBurnsView!

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    initSubviews()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    initSubviews()
  }

  func initSubviews() {
    let nib = UINib(nibName: "KenBurnView", bundle: nil)
    nib.instantiateWithOwner(self, options: nil)
    addSubview(kenBurnView)
  }
  
}