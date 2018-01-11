//
//  WeatherViewController.swift
//  SimpleWeather
//
//  Created by Piotr Basiński on 11.01.2018.
//  Copyright © 2018 Piotr Basiński. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

  var key = ""
  fileprivate var forecast: ForecastBaseClass? {
    didSet {
      updateUI()
    }
  }

  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.tableFooterView = UIView()
      tableView.dataSource = self
      tableView.delegate = self
    }
  }
  @IBOutlet weak var labelDate: UILabel!
  @IBOutlet weak var labelMax: UILabel!
  @IBOutlet weak var imageViewDay: UIImageView!
  @IBOutlet weak var labelMin: UILabel!
  @IBOutlet weak var imageViewNight: UIImageView!

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    NetworkEngine.shared.forecast(key: key) { (forecast, success) in
      if success {
        self.forecast = forecast
      }
    }
  }

  fileprivate func updateUI() {
    guard let forecast = forecast?.dailyForecasts?.first else {
      return
    }
    if let date = forecast.convenientDate {
      labelDate.text = date
    }
    if let tempDay = forecast.temperature?.maximum?.value {
      labelMax.text = "Day  \(tempDay)°C"
      labelMax.textColor = UIColor().getColorByValue(value: tempDay)
    }
    if let tempNight = forecast.temperature?.minimum?.value {
      labelMin.text = "Night  \(tempNight)°C"
      labelMin.textColor = UIColor().getColorByValue(value: tempNight)
    }
    if let dayIconName = forecast.day?.icon {
      imageViewDay.image = UIImage(named: String(dayIconName))
    }
    if let nightIconName = forecast.night?.icon {
      imageViewNight.image = UIImage(named: String(nightIconName))
    }
    tableView.reloadData()
  }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ForecastDayTableViewCell.self), for: indexPath) as! ForecastDayTableViewCell
    if let dayForecast = forecast?.dailyForecasts![indexPath.row] {
      cell.dayForecast = dayForecast
    }
    return cell
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return forecast?.dailyForecasts?.count ?? 0
  }
}
