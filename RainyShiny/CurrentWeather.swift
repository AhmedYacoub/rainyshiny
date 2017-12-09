//
//  CurrentWeather.swift
//  RainyShiny
//
//  Created by Ahmed Yacoub on 12/6/17.
//  Copyright © 2017 Ahmed Yacoub. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    var _cityName: String!
    var _date: String!
    var _weatherType: String!
    var _currentTemp: Int!
    
    
    // City name
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    // Date
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    // Weather type
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    // Current temprature
    var currentTemp: Int {
        if _currentTemp == nil {
            _currentTemp = 0
        }
        
        return _currentTemp
    }
    
    
    /** 
     * Download weather data from openweather API using Alamofire
     *
     * @param: DownloadCompleted
     **/
    func downloadWeatherDetails(completed: @escaping DownloadCompleted) {
        
        // transform the request API URL to an actual URL
        let weatherURL = URL(string: CURRENT_WEATHER_URL)!
        
        /* start Alamofire */
        
        // Get request and transform it to JSON response
        Alamofire.request(weatherURL).responseJSON { response in
            let result = response.result
            
            if let weatherDict = result.value as? Dictionary<String, AnyObject> {
                
                // Get city name
                if let name = weatherDict["name"] as? String {
                    self._cityName = name.capitalized
                }
                
                // Get weather type
                if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
                    
                    if let mainWeather = weather[0]["main"] as? String {
                        self._weatherType = mainWeather.capitalized
                    }
                }
                
                // Get current temperature
                if let main = weatherDict["main"] as? Dictionary<String, AnyObject> {
                    if let kelvin = main["temp"] as? Double {
                        let celsuis = kelvin - 273.12           // Celsuis = Kelvin - 273.15
                        self._currentTemp = Int(round(celsuis))
                    }
                }
            }
            completed()         // Alamofire response is completed
        }
    }
    
    
}

















