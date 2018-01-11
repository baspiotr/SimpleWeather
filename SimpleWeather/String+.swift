//
//  String+.swift
//  SimpleWeather
//
//  Created by Piotr Basiński on 11.01.2018.
//  Copyright © 2018 Piotr Basiński. All rights reserved.
//

import Foundation

extension String {
  func removeWhitespace() -> String {
    return components(separatedBy: .whitespaces).joined()
  }
}
