//
//  LocationViewModel.swift
//  keluarga-cemara
//
//  Created by M Yogi Satriawan on 24/10/23.
//

import SwiftUI
import CoreLocation
import SunKit

//TODO: fixing sun position data
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
       
        if trueHeading >= 0 && trueHeading < 45{
            direction = "North"
            orientationGarden = "North-facing garden doesn’t receive much sunlight and tend to be in the shade."
        } else if trueHeading >= 45 && trueHeading < 135 {
            direction = "East"
            orientationGarden = "East-facing garden experience sunlight during morning and shade in the afternoon or evening."
        } else if trueHeading >= 135 && trueHeading < 225 {
            direction = "South"
            orientationGarden = "South-facing garden tends to little shade and have sunlight for most hours of the day."
        } else if trueHeading >= 225 && trueHeading < 315 {
            direction = "West"
            orientationGarden = "West-facing garden gets ample afternoon and evening sunlight despite morning shade."
        } else if trueHeading >= 315 && trueHeading < 360 {
            direction = "North"
            orientationGarden = "North-facing garden doesn’t receive much sunlight and tend to be in the shade."
        }
        
//        print("Orientation: \(direction)")
    }
    
}
