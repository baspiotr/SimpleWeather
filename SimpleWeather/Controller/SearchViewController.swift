//
//  ViewController.swift
//  SimpleWeather
//
//  Created by Piotr Basiński on 11.01.2018.
//  Copyright © 2018 Piotr Basiński. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UIViewController, NSFetchedResultsControllerDelegate {

  @IBOutlet weak var searchBar: UISearchBar! {
    didSet {
      searchBar.delegate = self
    }
  }
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.delegate = self
      tableView.dataSource = self
      tableView.tableFooterView = UIView()
    }
  }

  fileprivate lazy var fetchedResultsController: NSFetchedResultsController<City> = {
    let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: k.sortDescriptor, ascending: true)]

    let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.shared.managedContext, sectionNameKeyPath: nil, cacheName: nil)
    fetchedResultsController.delegate = self
    return fetchedResultsController
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    performFetch()
  }

  fileprivate func performFetch() {
    do {
      try self.fetchedResultsController.performFetch()
    } catch {
      let fetchError = error as NSError
      print("Unable to Perform Fetch Request")
      print("\(fetchError), \(fetchError.localizedDescription)")
    }
    tableView.reloadData()
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == k.Segue.WeatherViewController {
      let key = sender as! String
      let vc = segue.destination as! WeatherViewController
      vc.key = key
    }
  }

  struct k {
    struct Cell {
      static let CityCell = "CityCell"
    }
    static let sortDescriptor = "name"
    struct Segue {
      static let WeatherViewController = "WeatherViewController"
    }
  }
}

extension SearchViewController: UISearchBarDelegate {

  func validateQuery(text: String) -> Bool {
    func matches(text: String) -> [String] {
      do {
        let regex = try NSRegularExpression(pattern: "[A-Za-z]")
        let nsString = text as NSString
        let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
        return results.map { nsString.substring(with: $0.range) }
      } catch let error {
        print("invalid regex: \(error.localizedDescription)")
        return []
      }
    }
    
    if matches(text: text).count == text.count {
      return true
    } else {
      return false
    }
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let query = searchBar.text?.removeWhitespace(), validateQuery(text: query) else {
      showAlert(title: "Validation Error", message: "Please use only letters from a to z.")
      return
    }

    self.view.endEditing(true)
    searchBar.text = ""

    NetworkEngine.shared.search(query: query) { (key, success) in
      if success {
        self.performFetch()
        self.performSegue(withIdentifier: k.Segue.WeatherViewController, sender: key)
      } else {
        self.showAlert(title: "Problem", message: "City not found or api key expired, please change in Xcode")
      }
    }
  }

  private func showAlert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: k.Cell.CityCell), for: indexPath)
    let city = fetchedResultsController.object(at: indexPath)
    if let name = city.name {
      cell.textLabel?.text = name
    }
    return cell
  }

  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == UITableViewCellEditingStyle.delete {
      let city = fetchedResultsController.object(at: indexPath)
      CoreDataStack.shared.managedContext.delete(city)
      CoreDataStack.shared.saveContext()
      performFetch()
    }
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let results = fetchedResultsController.fetchedObjects else { return 0 }
    return results.count
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let key = fetchedResultsController.object(at: indexPath).key {
      performSegue(withIdentifier: k.Segue.WeatherViewController, sender: key)
    }
  }
}
