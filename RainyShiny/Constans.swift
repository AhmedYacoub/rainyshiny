//
//  Constans.swift
//  RainyShiny
//
//  Created by Ahmed Yacoub on 12/6/17.
//  Copyright © 2017 Ahmed Yacoub. All rights reserved.
//

import Foundation


let BASE_URL  = "https://api.openweathermap.org/data/2.5/"
let CURRENT_WEATHER = "weather?"
let FORECAST  = "forecast/daily?"
let LATITUDE  = "lat=\(LocationSingleton.sharedInstance.latitude!)"
let LONGITUDE = "&lon=\(LocationSingleton.sharedInstance.longitude!)"
let NUMBER_OF_DAYS = "&cnt=7"
let APP_ID    = "&appid="
let API_KEY   = "bd5e378503939ddaee76f12ad7a97608"

typealias DownloadCompleted = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(CURRENT_WEATHER)\(LATITUDE)\(LONGITUDE)\(APP_ID)\(API_KEY)"



/**    https://api.openweathermap.org/data/2.5/forecast/daily?lat=35&lon=139&cnt=10&appid=bd5e378503939ddaee76f12ad7a97608 **/

let FORECAST_WEATHER_URL = "\(BASE_URL)\(FORECAST)\(LATITUDE)\(LONGITUDE)\(NUMBER_OF_DAYS)\(APP_ID)\(API_KEY)"

