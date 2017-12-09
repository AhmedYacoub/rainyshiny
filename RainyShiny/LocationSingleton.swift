//
//  LocationSingleton.swift
//  RainyShiny
//
//  Created by Ahmed Yacoub on 12/10/17.
//  Copyright © 2017 Ahmed Yacoub. All rights reserved.
//

import CoreLocation

// Singleton class to access its content globally
class LocationSingleton
{
    static var sharedInstance = LocationSingleton()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
    
}
