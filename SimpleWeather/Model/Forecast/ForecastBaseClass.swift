//
//  ForecastBaseClass.swift
//
//  Created by Piotr Basiński on 11/01/2018
//  Copyright (c) Piotr Basiński . All rights reserved.
//

import Foundation
import SwiftyJSON

public struct ForecastBaseClass {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kForecastBaseClassDailyForecastsKey: String = "DailyForecasts"
  private let kForecastBaseClassHeadlineKey: String = "Headline"

  // MARK: Properties
  public var dailyForecasts: [ForecastDailyForecasts]?
  public var headline: ForecastHeadline?

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
    if let items = json[kForecastBaseClassDailyForecastsKey].array { dailyForecasts = items.map { ForecastDailyForecasts(json: $0) } }
    headline = ForecastHeadline(json: json[kForecastBaseClassHeadlineKey])
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = dailyForecasts { dictionary[kForecastBaseClassDailyForecastsKey] = value.map { $0.dictionaryRepresentation() } }
    if let value = headline { dictionary[kForecastBaseClassHeadlineKey] = value.dictionaryRepresentation() }
    return dictionary
  }

}
