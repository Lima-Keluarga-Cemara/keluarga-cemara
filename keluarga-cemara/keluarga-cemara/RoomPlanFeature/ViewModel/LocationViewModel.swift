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
    @Published var timeZone : TimeZone?
    @Published var sun: Sun?
    @Published var sunExposure: String = "Unknown"
    @AppStorage("orientationDirection") var resultOrientationDirection : String?
    @Published var direction : String = "Unknown"
    @Published var orientationGarden : String = "Unknown"
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
            orientationGarden = "A north-facing garden typically doesn’t receive much sunlight and tend to be in the shade"
        } else if trueHeading >= 337.5 || trueHeading < 22.5 {
            direction = "North"
            orientationGarden = "A north-facing garden typically doesn’t receive much sunlight and tend to be in the shade"
        } else if trueHeading >= 22.5 && trueHeading < 67.5 {
            direction = "Northeast"
            orientationGarden = "Northeast"
        } else if trueHeading >= 67.5 && trueHeading < 112.5 {
            direction = "East"
            orientationGarden = "An east-facing garden will experience sunlight during morning and shade in the afternoon or evening"
        } else if trueHeading >= 112.5 && trueHeading < 157.5 {
            direction = "Southeast"
            orientationGarden = "Southeast"
        } else if trueHeading >= 157.5 && trueHeading < 202.5 {
            direction = "South"
            orientationGarden = "A south-facing garden tends to see very little shade, as they see sunlight for most hours of the day including evening"
        } else if trueHeading >= 202.5 && trueHeading < 247.5 {
            direction = "Southwest"
            orientationGarden = "Southwest"
        } else if trueHeading >= 247.5 && trueHeading < 292.5 {
            direction = "West"
            orientationGarden = "A west-facing garden gets ample afternoon and evening sunlight despite morning shade"
        } else if trueHeading >= 292.5 && trueHeading < 337.5 {
            direction = "Northwest"
            orientationGarden = "Northwest"
        }

        print("Orientation: \(direction)")
    }
    
    func isSunriseOrSunset() -> Bool {
        return true
    }
}
