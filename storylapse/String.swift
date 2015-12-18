//
//  String.swift
//  storylapse
//
//  Created by Lê Quang Bửu on 12/18/15.
//  Copyright © 2015 Lê Quang Bửu. All rights reserved.
//

import Foundation
extension String {
  
  func split(regex: String) -> Array<String> {
    do{
      let regEx = try NSRegularExpression(pattern: regex, options: NSRegularExpressionOptions())
      let stop = "<SomeStringThatYouDoNotExpectToOccurInSelf>"
      let modifiedString = regEx.stringByReplacingMatchesInString (self, options: NSMatchingOptions(), range: NSMakeRange(0, characters.count), withTemplate:stop)
      return modifiedString.componentsSeparatedByString(stop)
    } catch {
      return []
    }
  }
}