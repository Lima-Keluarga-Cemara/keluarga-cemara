//
//  LocationViewModel.swift
//  keluarga-cemara
//
//  Created by M Yogi Satriawan on 24/10/23.
//

import SwiftUI
import MapKit
import CoreLocation
import SunKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?
    //     add this for timeZone
    @Published var timeZone : TimeZone?
    @Published var sun: Sun?
    var orientationDirection: String = "Unknown"
    @Published var sunExposure: String = "Unknown"
    //    add this for direction
    @AppStorage("orientationDirection") var resultDirection : String?
    @Published var direction : String = "Unknown"
    
    
    
    @Published var region = MKCoordinateRegion()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationStatus = status
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
        self.timeZone = .init(identifier: "Asia/Jakarta") ?? .current
        sun = Sun(location: location, timeZone: timeZone!)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let trueHeading = newHeading.trueHeading
       
        
        self.direction = "Unknown"
        
        if trueHeading >= 0 && trueHeading < 22.5 {
            direction = "North"
        } else if trueHeading >= 337.5 || trueHeading < 22.5 {
            direction = "North"
        } else if trueHeading >= 22.5 && trueHeading < 67.5 {
            direction = "Northeast"
        } else if trueHeading >= 67.5 && trueHeading < 112.5 {
            direction = "East"
        } else if trueHeading >= 112.5 && trueHeading < 157.5 {
            direction = "Southeast"
        } else if trueHeading >= 157.5 && trueHeading < 202.5 {
            direction = "South"
        } else if trueHeading >= 202.5 && trueHeading < 247.5 {
            direction = "Southwest"
        } else if trueHeading >= 247.5 && trueHeading < 292.5 {
            direction = "West"
        } else if trueHeading >= 292.5 && trueHeading < 337.5 {
            direction = "Northwest"
        }
        orientationDirection = direction
        
        let isPartialSun = (orientationDirection == "Timur" || orientationDirection == "Barat") &&
        isSunriseOrSunset()
        
        let isFullSun = (orientationDirection == "Timur Laut" || orientationDirection == "Tenggara" || orientationDirection == "Barat Daya" || orientationDirection == "Barat Laut") &&
        isSunriseOrSunset()
        
        if isFullSun {
            orientationDirection = "Full Sun"
        } else if isPartialSun {
            orientationDirection = "Partial Sun"
        } else {
            orientationDirection = "Full sun"
        }
        
        print("Orientation: \(direction)")
        print("Sun Typical: \(orientationDirection)")
    }
    
    func isSunriseOrSunset() -> Bool {
        return true // Gantilah dengan logika perhitungan waktu sesuai lokasi Anda
    }
    
    
}
