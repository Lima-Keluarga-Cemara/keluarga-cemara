//
//  MapView.swift
//  keluarga-cemara
//
//  Created by M Yogi Satriawan on 22/10/23.
//

//import SwiftUI
//import MapKit
//import CoreLocation
//import SunKit
//
//
//
//@available(iOS 17.0, *)
//struct MapView: UIViewRepresentable {
//    @Binding var userLocation: CLLocation?
//    let locationManager = LocationManager()
//    let sunRiseAzimuth: Double
//    let sunSetAzimuth: Double
//
//    func makeUIView(context: Context) -> MKMapView {
//        let map = MKMapView()
//        map.showsUserLocation = true
//        map.showsCompass = true
//        map.userTrackingMode = .followWithHeading
//        map.delegate = context.coordinator
//        return map
//    }
//
//    func updateUIView(_ uiView: MKMapView, context: Context) {
//        uiView.removeAnnotations(uiView.annotations)
//
//        if let userLocation = userLocation {
//            addSunAnnotation(uiView: uiView, userLocation: userLocation, azimuth: sunRiseAzimuth, title: "Sunrise", symbolName: "sunrise.fill")
//            addSunAnnotation(uiView: uiView, userLocation: userLocation, azimuth: sunSetAzimuth, title: "Sunset", symbolName: "sunset.fill")
//        }
//    }
//
//    func addSunAnnotation(uiView: MKMapView, userLocation: CLLocation, azimuth: Double, title: String, symbolName: String) {
//        let annotation = MKPointAnnotation()
//        let locationCoordinate = userLocation.coordinate
//
//        let azimuthInRadians = (-azimuth - 180) * .pi / 180 // Adjust for MapKit coordinate system
//        let radius: Double = 0.005 // Adjust this for the distance from the user's location
//        let annotationLatitude = locationCoordinate.latitude + (radius * cos(azimuthInRadians))
//        let annotationLongitude = locationCoordinate.longitude + (radius * sin(azimuthInRadians))
//
//        annotation.coordinate = CLLocationCoordinate2D(latitude: annotationLatitude, longitude: annotationLongitude)
//        annotation.title = title
//
//        // Set the symbol using SF Symbols
//        let markerAnnotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "SunMarker")
//        markerAnnotationView.image = UIImage(systemName: symbolName)
//        markerAnnotationView.canShowCallout = true
//
//        uiView.addAnnotation(annotation)
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    @available(iOS 17.0, *)
//    class Coordinator: NSObject, MKMapViewDelegate {
//        var parent: MapView
//
//        init(_ parent: MapView) {
//            self.parent = parent
//        }
//
//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            guard annotation is MKPointAnnotation else { return nil }
//            return nil
//        }
//    }
//}
//
//
//
//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    private let locationManager = CLLocationManager()
//    @Published var locationStatus: CLAuthorizationStatus?
//    @Published var lastLocation: CLLocation?
////     add this for timeZone
//    @Published var timeZone : TimeZone?
//    @Published var sun: Sun?
//    var orientationDirection: String = "Unknown"
//    @Published var sunExposure: String = "Unknown"
//    var direction = "Unknown"
//
//    
//    @Published var region = MKCoordinateRegion()
//    
//    override init() {
//        super.init()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//        locationManager.startUpdatingHeading()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        locationStatus = status
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        lastLocation = location
//        self.timeZone = .init(identifier: "Asia/Jakarta") ?? .current
//        sun = Sun(location: location, timeZone: timeZone!)
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
//        let trueHeading = newHeading.trueHeading
//        
//        
//        if trueHeading >= 0 && trueHeading < 22.5 {
//            direction = "Utara"
//        } else if trueHeading >= 337.5 || trueHeading < 22.5 {
//            direction = "Utara"
//        } else if trueHeading >= 22.5 && trueHeading < 67.5 {
//            direction = "Timur Laut"
//        } else if trueHeading >= 67.5 && trueHeading < 112.5 {
//            direction = "Timur"
//        } else if trueHeading >= 112.5 && trueHeading < 157.5 {
//            direction = "Tenggara"
//        } else if trueHeading >= 157.5 && trueHeading < 202.5 {
//            direction = "Selatan"
//        } else if trueHeading >= 202.5 && trueHeading < 247.5 {
//            direction = "Barat Daya"
//        } else if trueHeading >= 247.5 && trueHeading < 292.5 {
//            direction = "Barat"
//        } else if trueHeading >= 292.5 && trueHeading < 337.5 {
//            direction = "Barat Laut"
//        }
//        orientationDirection = direction
//        
//        let isPartialSun = (orientationDirection == "Timur" || orientationDirection == "Barat") &&
//        isSunriseOrSunset()
//        
//        let isFullSun = (orientationDirection == "Timur Laut" || orientationDirection == "Tenggara" || orientationDirection == "Barat Daya" || orientationDirection == "Barat Laut") &&
//        isSunriseOrSunset()
//        
//        if isFullSun {
//            orientationDirection = "Full Sun"
//        } else if isPartialSun {
//            orientationDirection = "Partial Sun"
//        } else {
//            orientationDirection = "Full sun"
//        }
//        
//        print("Orientation: \(direction)")
//        print("Sun Typical: \(orientationDirection)")
//    }
//    
//    func isSunriseOrSunset() -> Bool {
//        return true // Gantilah dengan logika perhitungan waktu sesuai lokasi Anda
//    }
//}
//
//struct StartView:View {
//    @StateObject var locationManager = LocationManager()
//    @EnvironmentObject private var pathStore: PathStore
//
//    var body: some View {
//        ZStack{
//            if #available(iOS 17.0, *) {
//                MapView(userLocation: $locationManager.lastLocation, sunRiseAzimuth: locationManager.sun?.sunriseAzimuth ?? 0.0, sunSetAzimuth: locationManager.sun?.sunsetAzimuth ?? 0.0)
//            } else {
//                // Fallback on earlier versions
//            }
//            VStack{
//                StandardButton(text: "See garden orientation", color: Color("primaryGreen"), width: 320, height: 56) {
//                    pathStore.navigateToView(.orientationConfirmation)
//                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .bottom)
//            }
//        }
//
//    }
//}
