//
//  NetworkEngine.swift
//  SimpleWeather
//
//  Created by Piotr Basiński on 11.01.2018.
//  Copyright © 2018 Piotr Basiński. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import CoreData

class NetworkEngine {

  fileprivate var apiHandler: APIHandler
  static let shared = NetworkEngine(apiHandler: APIHandler())

  private init(apiHandler: APIHandler) {
    self.apiHandler = apiHandler
  }

  func search(query: String, completionHandler: @escaping (String?, Bool) -> ()) {
    let endpoint = Endpoint.search(query: query)

    apiHandler.request(endpoint: endpoint) { (json, success) in
      guard let json = json?.array?.first, success == true else {
        completionHandler(nil, false)
        return
      }

      let baseCity = CitySearchBaseClass(json: json)

      let cdContext = CoreDataStack.shared.managedContext
      let city = City(context: cdContext)
      if let name = baseCity.localizedName, let key = baseCity.key {
        city.name = name
        city.key = key
      }

      do {
        try cdContext.save()
      } catch let error as NSError {
        print("Save error: \(error), description: \(error.userInfo)")
      }

      completionHandler(baseCity.key, true)
    }
  }

  func forecast(key: String, completionHandler: @escaping (ForecastBaseClass?, Bool) -> ()) {
    let endpoint = Endpoint.forecast(key: key)

    apiHandler.request(endpoint: endpoint) { (json, success) in
      guard let json = json, success == true else {
        completionHandler(nil, false)
        return
      }
      let forecast = ForecastBaseClass(json: json)
      completionHandler(forecast, true)
    }
  }
}
