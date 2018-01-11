//
//  Endpoint.swift
//  SimpleWeather
//
//  Created by Piotr Basiński on 11.01.2018.
//  Copyright © 2018 Piotr Basiński. All rights reserved.
//

import Foundation
import Alamofire

fileprivate let apiKey = "lTSjeSivIWMQCjVqOzVoVkt2VJ495put"

enum Endpoint {
  case search(query: String)
  case forecast(key: String)

  var method: HTTPMethod {
    switch self {
    case .search, .forecast:
      return .get
    }
  }

  var path: String {
    switch self {
    case .search(let query):
      return "locations/v1/cities/search?apikey=\(apiKey)&q=\(query)"
    case .forecast(let key):
      return "forecasts/v1/daily/5day/\(key)?apikey=\(apiKey)&language=PL&metric=true"
    }
  }

  var parameters: [String: Any]? {
    switch self {
    case .search, .forecast:
      return nil
    }
  }
}
