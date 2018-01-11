//
//  AppDelegate.swift
//  SimpleWeather
//
//  Created by Piotr Basiński on 11.01.2018.
//  Copyright © 2018 Piotr Basiński. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func applicationDidEnterBackground(_ application: UIApplication) {
    CoreDataStack.shared.saveContext()
  }

  func applicationWillTerminate(_ application: UIApplication) {
    CoreDataStack.shared.saveContext()
  }

}
