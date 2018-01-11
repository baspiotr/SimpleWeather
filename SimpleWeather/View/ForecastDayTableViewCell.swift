//
//  ForecastDayTableViewCell.swift
//  SimpleWeather
//
//  Created by Piotr Basiński on 11.01.2018.
//  Copyright © 2018 Piotr Basiński. All rights reserved.
//

import UIKit

class ForecastDayTableViewCell: UITableViewCell {

  @IBOutlet weak var labelDate: UILabel!
  @IBOutlet weak var imageViewDay: UIImageView!
  @IBOutlet weak var labelMinTemp: UILabel!
  @IBOutlet weak var labelMaxTemp: UILabel!
  @IBOutlet weak var imageViewNight: UIImageView!

  var dayForecast: ForecastDailyForecasts? {
    didSet {
      updateUI()
    }
  }

  override func prepareForReuse() {
    super.prepareForReuse()

    labelDate.text = ""
    imageViewDay.image = UIImage()
    labelMinTemp.text = ""
    labelMaxTemp.text = ""
  }

  fileprivate func updateUI() {
    guard let day = dayForecast else {
      return
    }
    if let date = day.convenientDate {
      labelDate.text = date
    }
    if let min = day.temperature?.minimum?.value {
      labelMinTemp.text = "\(min)°C"
      labelMinTemp.textColor = UIColor().getColorByValue(value: min)
    }
    if let max = day.temperature?.maximum?.value {
      labelMaxTemp.text = "\(max)°C"
      labelMaxTemp.textColor =  UIColor().getColorByValue(value: max)
    }
    if let dayIconName = day.day?.icon {
      imageViewDay.image = UIImage(named: String(dayIconName))
    }
    if let nightIconName = day.night?.icon {
      imageViewNight.image = UIImage(named: String(nightIconName))
    }
  }
}
