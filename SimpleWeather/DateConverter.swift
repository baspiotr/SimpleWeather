//
//  DateConverter.swift
//  SimpleWeather
//
//  Created by Piotr Basiński on 11.01.2018.
//  Copyright © 2018 Piotr Basiński. All rights reserved.
//

import Foundation

public class DateConverter {
  
  var date: Date?
  fileprivate var dateFormatter = DateFormatter()
  
  var string: String? {
    get {
      guard let date = date else {
        return ""
      }
      dateFormatter.timeZone = TimeZone.current
      dateFormatter.dateFormat = "EEEE, MMM d, yyyy"
      let str = dateFormatter.string(from: date)
      return str
    }
  }
  
  init(dateString: String?) {
    guard let dateString = dateString else {
      return
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
    
    if let date = dateFormatter.date(from: dateString) {
      self.date = date
    } else {
      fatalError("DateConverter  init(dateString: String?)")
    }
  }
}
