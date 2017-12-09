//
//  WeatherVC.swift
//  RainyShiny
//
//  Created by Ahmed Yacoub on 12/5/17.
//  Copyright © 2017 Ahmed Yacoub. All rights reserved.
//

import UIKit
import CoreLocation     // access device Geolocation services
import Alamofire

// Location Manager: updates GPS coordinates
class WeatherVC: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var dataLabel: UILabel!                  // Tuesday, dec 15, 2017
    @IBOutlet weak var tembLabel: UILabel!                  // 22 °C
    @IBOutlet weak var cityLabel: UILabel!                  // Cairo, Egypt
    @IBOutlet weak var currentWeatherImage: UIImageView!    // Weather image
    @IBOutlet weak var currentWeatherState: UILabel!        // Current weather state ex: rainy, shiny, cloudy...
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest       // Get best accurcey for GPS location
        locationManager.requestWhenInUseAuthorization()                 // Use only when app is authorized to access GPS location
        locationManager.startMonitoringSignificantLocationChanges()     // Keep track of significant GPS changes
        
        tableView.dataSource = self
        tableView.delegate = self
        
        currentWeather = CurrentWeather()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationAuthStatus()
        
        // Download current weather then forecasts and then update UI
        currentWeather.downloadWeatherDetails {
            self.forecastWeatherDetails {
                self.updateMainUI()
                
            }
        }
    }
    
    // Ask for GPS authorization and get location
    func locationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            // if app is authorized to access GPS services
            currentLocation = locationManager.location
            
            // save coordinates to singleton class
            LocationSingleton.sharedInstance.latitude  = currentLocation.coordinate.latitude
            LocationSingleton.sharedInstance.longitude = currentLocation.coordinate.longitude
        } else {
            // request app authorization to access GPS services
            locationManager.requestWhenInUseAuthorization()
            // call it again
            locationAuthStatus()
        }
    }
    
    // Get forecast data
    func forecastWeatherDetails(completed: @escaping DownloadCompleted) {
        let forecastURL = URL(string: FORECAST_WEATHER_URL)!
        print(FORECAST_WEATHER_URL)

        Alamofire.request(forecastURL).responseJSON { response in
            
            let result = response.result
            
            if let forecastDict = result.value as? Dictionary<String, AnyObject> {
                if let list = forecastDict["list"] as? [Dictionary<String, AnyObject>] {
                    // foreach day in list
                    for obj in list {
                        let forecast = Forecast(weatherDic: obj)
                        self.forecasts.append(forecast)
                    }
                    	
                    self.forecasts.remove(at: 0)    // Remove first index "Today forecast" to avoid doublication
                    self.tableView.reloadData()     // Refresh table view to show new data
                }
            }
            
            completed()
        }
    }

    
    // Table Cell implementation
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? ForecastCell {
            let forecastObj = forecasts[indexPath.row]         // get index of the array of the required cell
            cell.seedCell(forecast: forecastObj)               // pass an object
            
            return cell
        } else {
            return ForecastCell()
        }
    }
    
    /**
     * function updateMainUI to update UI with API data
     **/
    func updateMainUI() {
        dataLabel.text = currentWeather.date
        tembLabel.text = "\(currentWeather.currentTemp)°c"
        cityLabel.text = " \(currentWeather.cityName)"
        currentWeatherState.text = currentWeather.weatherType
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
    }

}

