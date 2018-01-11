//
//  CitySearchBaseClass.swift
//
//  Created by Piotr Basiński on 11/01/2018
//  Copyright (c) PiotrBasinski. All rights reserved.
//

import Foundation
import SwiftyJSON

public struct CitySearchBaseClass {

  private let kCitySearchBaseClassLocalizedNameKey: String = "LocalizedName"
  private let kCitySearchBaseClassKeyKey: String = "Key"

  public var localizedName: String?
  public var key: String?

  public init(json: JSON) {
    localizedName = json[kCitySearchBaseClassLocalizedNameKey].string
    key = json[kCitySearchBaseClassKeyKey].string
  }

  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]

    if let value = localizedName { dictionary[kCitySearchBaseClassLocalizedNameKey] = value }
    if let value = key { dictionary[kCitySearchBaseClassKeyKey] = value }

    return dictionary
  }
}
