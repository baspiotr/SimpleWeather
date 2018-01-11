//
//  UIColor+.swift
//  SimpleWeather
//
//  Created by Piotr Basiński on 11.01.2018.
//  Copyright © 2018 Piotr Basiński. All rights reserved.
//

import UIKit

extension UIColor {
  func getColorByValue(value: Float) -> UIColor {
    switch value {
    case _ where value <= 10:
      return UIColor.blue
    case _ where value <= 20:
      return UIColor.black
    case _ where value > 20:
      return UIColor.red
    default:
      return UIColor.white
    }
  }
}
