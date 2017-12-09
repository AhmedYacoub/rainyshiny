//
//  ForecastCell.swift
//  RainyShiny
//
//  Created by Ahmed Yacoub on 12/9/17.
//  Copyright © 2017 Ahmed Yacoub. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {

    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var weatherDay: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    
    func seedCell(forecast: Forecast) {
        // seed every cell with its data
        weatherIcon.image = UIImage(named: forecast.weatherType)    // weather icon
        weatherDay.text   = forecast.date                           // weather date day
        weatherType.text  = forecast.weatherType                    // weather type
        highTemp.text = forecast.highTemp                           // weather high temperature
        lowTemp.text  = forecast.lowTemp                            // weather low temperature
    }

}
