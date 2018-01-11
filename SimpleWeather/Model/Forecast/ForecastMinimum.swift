//
//  ForecastMinimum.swift
//
//  Created by Piotr Basiński on 11/01/2018
//  Copyright (c) Piotr Basiński . All rights reserved.
//

import Foundation
import SwiftyJSON

public struct ForecastMinimum {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kForecastMinimumUnitKey: String = "Unit"
  private let kForecastMinimumValueKey: String = "Value"
  private let kForecastMinimumUnitTypeKey: String = "UnitType"

  // MARK: Properties
  public var unit: String?
  public var value: Float?
  public var unitType: Int?

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
    unit = json[kForecastMinimumUnitKey].string
    value = json[kForecastMinimumValueKey].float
    unitType = json[kForecastMinimumUnitTypeKey].int
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = unit { dictionary[kForecastMinimumUnitKey] = value }
    if let value = value { dictionary[kForecastMinimumValueKey] = value }
    if let value = unitType { dictionary[kForecastMinimumUnitTypeKey] = value }
    return dictionary
  }

}
