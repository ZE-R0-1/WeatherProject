//
//  LocationManager.swift
//  WeatherPro
//
//  Created by 윤준영 on 2023/07/04.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    static let shared = LocationManager()
    private override init() {
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        
        super.init()
        
        manager.delegate = self
    }
    
    let manager: CLLocationManager
    
    var currentLocationTitle: String?
    
    func updateLocation() {
        let status: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            status = manager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:
            requestAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            requestCurrentLocation()
        case .denied, .restricted:
            print("not available")
        default:
            print("unknown")
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    private func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    
    private func requestCurrentLocation() {
        //manager.startUpdatingLocation()
        manager.requestLocation()
    }
    
    private func updateAddress(from location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self](placmarks, error) in
            if let error = error {
                print(error)
                self?.currentLocationTitle = "Unknown"
                return
            }
            
            if let placmark = placmarks?.first {
                if let gu = placmark.locality, let dong = placmark.subLocality {
                    self?.currentLocationTitle = "\(gu) \(dong)"
                } else {
                    self?.currentLocationTitle = placmark.name ?? "Unknown"
                }
            }
            
            print(self?.currentLocationTitle)
        }
    }
    
    @available(iOS 14.0, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            requestCurrentLocation()
        case .notDetermined, .denied, .restricted:
            print("not available")
        default:
            print("unknown")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            requestCurrentLocation()
        case .notDetermined, .denied, .restricted:
            print("not available")
        default:
            print("unknown")
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print(locations.last)
        
        if let location = locations.last {
            updateAddress(from: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
