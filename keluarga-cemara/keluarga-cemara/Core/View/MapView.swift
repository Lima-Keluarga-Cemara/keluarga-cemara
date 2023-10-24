//
//  MapView.swift
//  keluarga-cemara
//
//  Created by M Yogi Satriawan on 22/10/23.
//




import SwiftUI
import MapKit
import CoreLocation
import SunKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?
    @Published var sun: Sun?
    var orientationDirection: String = "Unknown"
    @Published var sunExposure: String = "Unknown"

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
        let timeZone: TimeZone = .init(identifier: "UTC") ?? .current
        sun = Sun(location: location, timeZone: timeZone)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let trueHeading = newHeading.trueHeading
        
        
        var direction = "Unknown"
        
        if trueHeading >= 0 && trueHeading < 22.5 {
            direction = "Utara"
        } else if trueHeading >= 337.5 || trueHeading < 22.5 {
            direction = "Utara"
        } else if trueHeading >= 22.5 && trueHeading < 67.5 {
            direction = "Timur Laut"
        } else if trueHeading >= 67.5 && trueHeading < 112.5 {
            direction = "Timur"
        } else if trueHeading >= 112.5 && trueHeading < 157.5 {
            direction = "Tenggara"
        } else if trueHeading >= 157.5 && trueHeading < 202.5 {
            direction = "Selatan"
        } else if trueHeading >= 202.5 && trueHeading < 247.5 {
            direction = "Barat Daya"
        } else if trueHeading >= 247.5 && trueHeading < 292.5 {
            direction = "Barat"
        } else if trueHeading >= 292.5 && trueHeading < 337.5 {
            direction = "Barat Laut"
        }
        orientationDirection = direction
                // Menentukan paparan sinar matahari berdasarkan orientasi dan waktu matahari terbit/terbenam
                let isPartialSun = (orientationDirection == "Timur" || orientationDirection == "Barat") &&
                                isSunriseOrSunset() // Fungsi ini memeriksa apakah saat ini matahari terbit atau terbenam
                
                let isFullSun = (orientationDirection == "Timur Laut" || orientationDirection == "Tenggara" || orientationDirection == "Barat Daya" || orientationDirection == "Barat Laut") &&
                                   isSunriseOrSunset()
                
                if isFullSun {
                    orientationDirection = "Full Sun"
                } else if isPartialSun {
                    orientationDirection = "Partial Sun"
                } else {
                    orientationDirection = "Full sun"
                }

   
        func isSunriseOrSunset() -> Bool {
             
              return true // Gantilah dengan logika perhitungan waktu sesuai lokasi Anda
          }
        print("Orientation: \(direction)")
        print("Sun Typical: \(orientationDirection)")
    }


    
    
}


@available(iOS 17.0, *)
struct MapView: UIViewRepresentable {
    @Binding var userLocation: CLLocation?
    let locationManager = LocationManager()

   

    func makeUIView(context: Context) -> MKMapView {
        let map = MKMapView()
        map.showsUserLocation = true
        map.showsCompass = true
        map.userTrackingMode = .followWithHeading
        map.delegate = context.coordinator
        return map
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations) // Remove existing annotations
       
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

   

    @available(iOS 17.0, *)
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

     
    }
}
