//
//  ForecastNight.swift
//
//  Created by Piotr Basiński on 11/01/2018
//  Copyright (c) Piotr Basiński . All rights reserved.
//

import Foundation
import SwiftyJSON

public struct ForecastNight {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kForecastNightIconPhraseKey: String = "IconPhrase"
  private let kForecastNightIconKey: String = "Icon"

  // MARK: Properties
  public var iconPhrase: String?
  public var icon: Int?

  // MARK: SwiftyJSON Initalizers
  /**
   Initates the instance based on the object
   - parameter object: The object of either Dictionary or Array kind that was passed.
   - returns: An initalized instance of the class.
  */
  public init(object: Any) {
    self.init(json: JSON(object))
  }

  /**
   Initates the instance based on the JSON that was passed.
   - parameter json: JSON object from SwiftyJSON.
   - returns: An initalized instance of the class.
  */
  public init(json: JSON) {
    iconPhrase = json[kForecastNightIconPhraseKey].string
    icon = json[kForecastNightIconKey].int
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = iconPhrase { dictionary[kForecastNightIconPhraseKey] = value }
    if let value = icon { dictionary[kForecastNightIconKey] = value }
    return dictionary
  }

}
