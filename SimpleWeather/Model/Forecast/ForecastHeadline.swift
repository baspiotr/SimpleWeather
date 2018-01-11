//
//  ForecastHeadline.swift
//
//  Created by Piotr Basiński on 11/01/2018
//  Copyright (c) Piotr Basiński . All rights reserved.
//

import Foundation
import SwiftyJSON

public struct ForecastHeadline {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kForecastHeadlineEffectiveEpochDateKey: String = "EffectiveEpochDate"
  private let kForecastHeadlineSeverityKey: String = "Severity"
  private let kForecastHeadlineEffectiveDateKey: String = "EffectiveDate"
  private let kForecastHeadlineMobileLinkKey: String = "MobileLink"
  private let kForecastHeadlineEndEpochDateKey: String = "EndEpochDate"
  private let kForecastHeadlineTextKey: String = "Text"
  private let kForecastHeadlineCategoryKey: String = "Category"
  private let kForecastHeadlineLinkKey: String = "Link"
  private let kForecastHeadlineEndDateKey: String = "EndDate"

  // MARK: Properties
  public var effectiveEpochDate: Int?
  public var severity: Int?
  public var effectiveDate: String?
  public var mobileLink: String?
  public var endEpochDate: Int?
  public var text: String?
  public var category: String?
  public var link: String?
  public var endDate: String?

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
    effectiveEpochDate = json[kForecastHeadlineEffectiveEpochDateKey].int
    severity = json[kForecastHeadlineSeverityKey].int
    effectiveDate = json[kForecastHeadlineEffectiveDateKey].string
    mobileLink = json[kForecastHeadlineMobileLinkKey].string
    endEpochDate = json[kForecastHeadlineEndEpochDateKey].int
    text = json[kForecastHeadlineTextKey].string
    category = json[kForecastHeadlineCategoryKey].string
    link = json[kForecastHeadlineLinkKey].string
    endDate = json[kForecastHeadlineEndDateKey].string
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = effectiveEpochDate { dictionary[kForecastHeadlineEffectiveEpochDateKey] = value }
    if let value = severity { dictionary[kForecastHeadlineSeverityKey] = value }
    if let value = effectiveDate { dictionary[kForecastHeadlineEffectiveDateKey] = value }
    if let value = mobileLink { dictionary[kForecastHeadlineMobileLinkKey] = value }
    if let value = endEpochDate { dictionary[kForecastHeadlineEndEpochDateKey] = value }
    if let value = text { dictionary[kForecastHeadlineTextKey] = value }
    if let value = category { dictionary[kForecastHeadlineCategoryKey] = value }
    if let value = link { dictionary[kForecastHeadlineLinkKey] = value }
    if let value = endDate { dictionary[kForecastHeadlineEndDateKey] = value }
    return dictionary
  }

}
