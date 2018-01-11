//
//  APIHandler.swift
//  SimpleWeather
//
//  Created by Piotr Basiński on 11.01.2018.
//  Copyright © 2018 Piotr Basiński. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIHandler {
  private let baseURL = "https://dataservice.accuweather.com/"

  func request(endpoint: Endpoint, completionHandler: @escaping (_ json: JSON?, _ success: Bool) -> ()) {
    let url = baseURL + endpoint.path

    Alamofire.request(url, method: endpoint.method, parameters: endpoint.parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
      debugPrint(response)
      if let status = response.response?.statusCode {
        switch status {
        case 400...511:
          print("error with response status: \(status)")

          completionHandler(nil, false)
        default:
          print("\(endpoint.path) + \(String(describing: endpoint.parameters)) success")
        }
      }
      if let result = response.result.value {
        let json = JSON(result)
        completionHandler(json, true)
      } else {
        completionHandler(nil, false)
      }
    }
  }
}
