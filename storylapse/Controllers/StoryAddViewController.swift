//
//  StoryAddViewController.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/18/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import UIKit

class StoryAddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
  
  @IBOutlet var hourPickerView: UIPickerView!
  @IBOutlet var minutePickerView: UIPickerView!
  @IBOutlet var mondayButton: UIButton!
  @IBOutlet var tuesdayButton: UIButton!
  @IBOutlet var wednesdayButton: UIButton!
  @IBOutlet var thursdayButton: UIButton!
  @IBOutlet var fridayButton: UIButton!
  @IBOutlet var saturdayButton: UIButton!
  @IBOutlet var sundayButton: UIButton!
  @IBOutlet var titleTextField: TextField!
  @IBOutlet var hashtagsTextField: TextField!
  @IBOutlet var createButton: UIButton!
  var hourPickerDataBase = [String]()
  var minutePickerDataBase = [String]()
  var hour = String()
  var minute = String()
  
  var story: Story?
  var _reminderAtDays: [String: [String]]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Add new story"
    view.backgroundColor = Colors.primaryBackgroundColor
    (tabBarController as! SLTabBarController).toggleTabBar(animated: false, showed: false)
    
    createButton.backgroundColor = Colors.tintColor
    createButton.tintColor = UIColor.whiteColor()

    hourPickerDataBase = ["0", "1", "2" , "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23"]
    minutePickerDataBase = ["0", "1", "2" , "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26" , "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
    _reminderAtDays = ["Days" : ["", "", "", "", "", "", ""] ]
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
  
  @IBAction func handleCreateButtonTap(sender: UIButton) {
    story?.title = titleTextField.text!
    story?.hashtags = hashtagsTextField.text!.split("\\s*,\\s*")
    
    try! story?.save()
    navigationController?.popViewControllerAnimated(true)
  }

// MARK: handle hour and minute picker view

  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    if (pickerView.tag == 1){
      return hourPickerDataBase.count
    } else{
      return minutePickerDataBase.count
    }
  }

  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    if (pickerView.tag == 1){
      return hourPickerDataBase[component]
    } else{
      return minutePickerDataBase[component]
    }
  }

  func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
    if pickerView.tag == 1 {
      let titleData1 = hourPickerDataBase[row]
      let myTitle1 = NSAttributedString(string: titleData1, attributes: [NSForegroundColorAttributeName: UIColor.blueColor()])
      return myTitle1
    } else {
      let titleData2 = minutePickerDataBase[row]
      let myTitle2 = NSAttributedString(string: titleData2, attributes: [NSForegroundColorAttributeName: UIColor.blueColor()])
      return myTitle2
    }
  }

  func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
    if pickerView.tag == 1 {
      let hourPickerLabel = UILabel()
      hourPickerLabel.textColor = UIColor.blueColor()
      hourPickerLabel.text = hourPickerDataBase[row]
      hourPickerLabel.font = UIFont(name: "Arial-BoldMT", size: 25)
      hourPickerLabel.textAlignment = NSTextAlignment.Center
      return hourPickerLabel
    } else {
      let minutePickerLabel = UILabel()
      minutePickerLabel.textColor = UIColor.blueColor()
      minutePickerLabel.text = minutePickerDataBase[row]
      minutePickerLabel.font = UIFont(name: "Arial-BoldMT", size: 25)
      minutePickerLabel.textAlignment = NSTextAlignment.Center
      return minutePickerLabel
    }
  }

  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    if pickerView.tag == 1 {
      print("hourPickerDataBase[row] is \(hourPickerDataBase[row])")
      hour = hourPickerDataBase[row]
      story?.reminderAtHour["Hour"] = hour
      print(story?.reminderAtHour["Hour"])
    } else {
      print("minutePickerDataBase[row] is \(minutePickerDataBase[row])")
      minute = minutePickerDataBase[row]
      story?.reminderAtMinute["Minute"] = minute
      print(story?.reminderAtMinute["Minute"])
    }
  }

// MARK: handle day buttons tap

  @IBAction func handleMondayButtonTap(sender: AnyObject) {
    if mondayButton.backgroundColor == nil {
      mondayButton.backgroundColor = UIColor.greenColor()
      _reminderAtDays!["Days"]![0] = "Monday"
      story?.reminderAtDays = _reminderAtDays!
      print(story?.reminderAtDays)
    } else {
      mondayButton.backgroundColor = nil
      _reminderAtDays!["Days"]![0] = ""
      story?.reminderAtDays = _reminderAtDays!
      print(story?.reminderAtDays)
    }
  }
  @IBAction func handleTuesdayButtonTap(sender: AnyObject) {
    if tuesdayButton.backgroundColor == nil {
      tuesdayButton.backgroundColor = UIColor.greenColor()
      _reminderAtDays!["Days"]![1] = "Tuesday"
      story?.reminderAtDays = _reminderAtDays!
      print(story?.reminderAtDays)
    } else {
      tuesdayButton.backgroundColor = nil
      _reminderAtDays!["Days"]![1] = ""
      story?.reminderAtDays = _reminderAtDays!
      print(story?.reminderAtDays)
    }
  }
  @IBAction func handleWednesdayButtonTap(sender: AnyObject) {
    if wednesdayButton.backgroundColor == nil {
      wednesdayButton.backgroundColor = UIColor.greenColor()
      _reminderAtDays!["Days"]![2] = "Wednesday"
      story?.reminderAtDays = _reminderAtDays!
      print(story?.reminderAtDays)
    } else {
      wednesdayButton.backgroundColor = nil
      _reminderAtDays!["Days"]![2] = ""
      story?.reminderAtDays = _reminderAtDays!
      print(story?.reminderAtDays)
    }
  }
  @IBAction func handleThursdayButtonTap(sender: AnyObject) {
    if thursdayButton.backgroundColor == nil {
      thursdayButton.backgroundColor = UIColor.greenColor()
      _reminderAtDays!["Days"]![3] = "Thursday"
      story?.reminderAtDays = _reminderAtDays!
      print(story?.reminderAtDays)
    } else {
      thursdayButton.backgroundColor = nil
      _reminderAtDays!["Days"]![3] = ""
      story?.reminderAtDays = _reminderAtDays!
      print(story?.reminderAtDays)
    }
  }
  @IBAction func handleFridayButtonTap(sender: AnyObject) {
    if fridayButton.backgroundColor == nil {
      fridayButton.backgroundColor = UIColor.greenColor()
      _reminderAtDays!["Days"]![4] = "Friday"
      story?.reminderAtDays = _reminderAtDays!
      print(story?.reminderAtDays)
    } else {
      fridayButton.backgroundColor = nil
      _reminderAtDays!["Days"]![4] = ""
      story?.reminderAtDays = _reminderAtDays!
      print(story?.reminderAtDays)
    }
  }
  @IBAction func handleSaturdayButtonTap(sender: AnyObject) {
    if saturdayButton.backgroundColor == nil {
      saturdayButton.backgroundColor = UIColor.greenColor()
      _reminderAtDays!["Days"]![5] = "Saturday"
      story?.reminderAtDays = _reminderAtDays!
      print(story?.reminderAtDays)
    } else {
      saturdayButton.backgroundColor = nil
      _reminderAtDays!["Days"]![5] = ""
      story?.reminderAtDays = _reminderAtDays!
      print(story?.reminderAtDays)
    }
  }
  @IBAction func handleSundayButtonTap(sender: AnyObject) {
    if sundayButton.backgroundColor == nil {
      sundayButton.backgroundColor = UIColor.greenColor()
      _reminderAtDays!["Days"]![6] = "Sunday"
      story?.reminderAtDays = _reminderAtDays!
      print(story?.reminderAtDays)
    } else {
      sundayButton.backgroundColor = nil
      _reminderAtDays!["Days"]![6] = ""
      story?.reminderAtDays = _reminderAtDays!
      print(story?.reminderAtDays)
    }
  }
}
