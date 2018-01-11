//
//  ForecastDailyForecasts.swift
//
//  Created by Piotr Basiński on 11/01/2018
//  Copyright (c) Piotr Basiński . All rights reserved.
//

import Foundation
import SwiftyJSON

public struct ForecastDailyForecasts {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kForecastDailyForecastsNightKey: String = "Night"
  private let kForecastDailyForecastsMobileLinkKey: String = "MobileLink"
  private let kForecastDailyForecastsEpochDateKey: String = "EpochDate"
  private let kForecastDailyForecastsTemperatureKey: String = "Temperature"
  private let kForecastDailyForecastsLinkKey: String = "Link"
  private let kForecastDailyForecastsSourcesKey: String = "Sources"
  private let kForecastDailyForecastsDateKey: String = "Date"
  private let kForecastDailyForecastsDayKey: String = "Day"

  // MARK: Properties
  public var night: ForecastNight?
  public var mobileLink: String?
  public var epochDate: Int?
  public var temperature: ForecastTemperature?
  public var link: String?
  public var sources: [String]?
  public var date: String?
  public var convenientDate: String? {
    get {
      return DateConverter(dateString: date).string
    }
  }
  public var day: ForecastDay?

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
    night = ForecastNight(json: json[kForecastDailyForecastsNightKey])
    mobileLink = json[kForecastDailyForecastsMobileLinkKey].string
    epochDate = json[kForecastDailyForecastsEpochDateKey].int
    temperature = ForecastTemperature(json: json[kForecastDailyForecastsTemperatureKey])
    link = json[kForecastDailyForecastsLinkKey].string
    if let items = json[kForecastDailyForecastsSourcesKey].array { sources = items.map { $0.stringValue } }
    date = json[kForecastDailyForecastsDateKey].string
    day = ForecastDay(json: json[kForecastDailyForecastsDayKey])
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = night { dictionary[kForecastDailyForecastsNightKey] = value.dictionaryRepresentation() }
    if let value = mobileLink { dictionary[kForecastDailyForecastsMobileLinkKey] = value }
    if let value = epochDate { dictionary[kForecastDailyForecastsEpochDateKey] = value }
    if let value = temperature { dictionary[kForecastDailyForecastsTemperatureKey] = value.dictionaryRepresentation() }
    if let value = link { dictionary[kForecastDailyForecastsLinkKey] = value }
    if let value = sources { dictionary[kForecastDailyForecastsSourcesKey] = value }
    if let value = date { dictionary[kForecastDailyForecastsDateKey] = value }
    if let value = day { dictionary[kForecastDailyForecastsDayKey] = value.dictionaryRepresentation() }
    return dictionary
  }

}
