//
//  StoryAddViewController.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/18/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit
import Cartography

class StoryAddViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet var descriptionTextView: UITextView!
  @IBOutlet var hourPickerView: UIPickerView!
  @IBOutlet var minutePickerView: UIPickerView!
  @IBOutlet var titleTextField: TextField!
  @IBOutlet var hashtagsTextField: TextField!
  @IBOutlet var createButton: UIButton!
  @IBOutlet var weekDaysView: UIView!
  
  var hour = String()
  var minute = String()
  var notification = RemindNotification()
  
  var story: Story?
  
  private var daysOfWeek: [Bool] = [true, true, true, true, true, true, true] {
    didSet {
      daysOfWeek.enumerate().forEach {
        let button = dayOfWeekButtons[$0.0]
        
        button.backgroundColor = $0.1 ?
          Colors.canvasColor :
          UIColor.clearColor()
        
        button.alpha = $0.1 ? 1 : 0.5
      }
      
      dayOfWeekButtons.first!.tintColor = UIColor.redColor()
    }
  }
  
  private lazy var dayOfWeekButtons: [UIButton]  = { [unowned self] in
    let weekDaysView = self.weekDaysView
    let buttons: [UIButton] = ["M", "T", "W", "T", "F", "S", "S"]
      .map { title in
        let button = UIButton(type: .System)
        button.setTitle(title, forState: .Normal)
        return button
    }
    
    buttons.forEach{ weekDaysView.addSubview($0) }
    
    let lastButton = buttons.reduce(nil) { (lastButton, button) -> UIButton? in
      if let lastButton = lastButton {
        constrain(button, lastButton) { button, lastButton in
          button.width == lastButton.width
          button.left == lastButton.right + 8
        }
        
      } else {
        constrain(button, weekDaysView) { button, view in
          button.left == view.leftMargin
        }
      }
      
      constrain(button, weekDaysView) { button, view in
        button.top == view.topMargin
        align(centerY: view, button)
      }
      
      return button
    }!
    
    constrain(lastButton, weekDaysView) { button, view in
      button.right == view.rightMargin
    }
    
    weekDaysView.layoutIfNeeded()
    return [lastButton] + buttons[0..<buttons.count - 1]
    
    }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Add new story"
    view.backgroundColor = Colors.primaryBackgroundColor
    (tabBarController as! SLTabBarController).toggleTabBar(animated: false, showed: false)
    
    
    titleTextField.delegate = self
    titleTextField.becomeFirstResponder()
    
    descriptionTextView.backgroundColor = Colors.canvasColor
    descriptionTextView.textColor = Colors.primaryTextColor
    descriptionTextView.layer.borderWidth = 1
    descriptionTextView.layer.borderColor = Colors.borderColor.CGColor
    descriptionTextView.attributedText = NSAttributedString(string: "Description",
      attributes:[NSForegroundColorAttributeName: Colors.placeholderTextColor])
    
    createButton.backgroundColor = Colors.tintColor
    createButton.tintColor = UIColor.whiteColor()
    
    dayOfWeekButtons.forEach { $0.addTarget(self, action: "handleDayOfWeekButtonTap:", forControlEvents: .TouchUpInside) }
    
    daysOfWeek = [true, true, true, true, true, true, true]
  }
  
  override func viewWillAppear(animated: Bool) {
    if story == nil {
      story = Story.create(getDatabase())
    }
    
    titleTextField.text = story?.title
    hashtagsTextField.text = story?.hashtags.joinWithSeparator(", ")
    super.viewWillAppear(animated)
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    (tabBarController as! SLTabBarController).toggleTabBar(animated: true, showed: true)
  }
  
  @IBAction func handleViewTap(sender: AnyObject) {
    view.endEditing(true)
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    titleTextField.resignFirstResponder()
    return true
  }
  
  func showAlertViewWhenTitleIsNil() {
    let actionSheet = UIAlertController(title: "", message: "Your story title is empty", preferredStyle: UIAlertControllerStyle.Alert)
    let cancelButtonAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { (UIAlertAction) -> Void in
      print("Cancel")
    }
    actionSheet.addAction(cancelButtonAction)
    self.presentViewController(actionSheet, animated: true, completion: nil)
  }
  
  @IBAction func handleCreateButtonTap(sender: UIButton) {
    if titleTextField.text == "" {
      showAlertViewWhenTitleIsNil()
    } else {
      story?.title = titleTextField.text!
      story?.hashtags = hashtagsTextField.text!.split("\\s*,\\s*")
      
      try! story?.save()
      notification.notification(story!)
      navigationController?.popViewControllerAnimated(true)
    }
  }

  // MARK: Handle day buttons tap
  func handleDayOfWeekButtonTap(sender: UIButton) {
    let index = dayOfWeekButtons.indexOf(sender)!
    daysOfWeek[index] = !daysOfWeek[index]
  }
}

// MARK: Picker view
extension StoryAddViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  
  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerView.tag == 1 ? 24 : 60
  }
  
  func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
    let label = UILabel()
    
    label.textColor = Colors.tintColor
    label.text = String(format: pickerView.tag == 1 ? "%d" : "%02d", row)
    label.font = UIFont(name: "Arial-BoldMT", size: 32)
    label.textAlignment = NSTextAlignment.Center
    
    return label
  }
  
  func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
    return 36
  }
  
  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerView.tag == 1 {
      story?.remindeAtHour = row
      
    } else {
      story?.remindeAtMinute = row
    }
    
    view.endEditing(true)
  }
}