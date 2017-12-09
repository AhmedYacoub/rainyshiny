//
//  Forecast.swift
//  RainyShiny
//
//  Created by Ahmed Yacoub on 12/7/17.
//  Copyright © 2017 Ahmed Yacoub. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    // Date
    var date: String {
        if _date == nil {
            _date = ""
        }
        
        return _date
    }
    
    // Weather type
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    // High temperature
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        
        return _highTemp
    }
    
    // Low temperature
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        
        return _lowTemp
    }
    
    // High and min temperature
    init (weatherDic: Dictionary<String, AnyObject>) {
        if let temp = weatherDic["temp"] as? Dictionary<String, AnyObject> {
            
            // Max temperature
            if let max = temp["max"] as? Double {
                let high = Int (max - 273.15)                                   // conversion from Kelvin to Celsuis
                _highTemp = "\(high)"
            }
            
            // Min temperature
            if let min = temp["min"] as? Double {
                let low = Int (min - 273.15)                                    // conversion from Kelvin to Celsuis
                _lowTemp = "\(low)"
            }
        }
        
        // Weather state
        if let weather = weatherDic["weather"] as? [Dictionary<String, AnyObject>] {
            if let main = weather[0]["main"] as? String {
                _weatherType = main
            }
        }
        
        if let date = weatherDic["dt"] as? Double {
            let unixDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle  = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle  = .none
            
            self._date = unixDate.dayOfTheWeek()
        }
    }
    
}


/** Instead of NSDate **/
extension Date {
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        return dateFormatter.string(from: self)
    }
}
