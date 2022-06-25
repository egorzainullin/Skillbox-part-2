//
//  LocationManager.swift
//  Task10
//
//  Created by Егор Зайнуллин on 25.06.2022.
//

import CoreLocation

class LocationManager: NSObject {
    static let shared = LocationManager()
    
    typealias AccessRequestBlock = (Bool) -> ()
    typealias LocationRequestBlock = (CLLocationCoordinate2D?) -> ()
    
    private let locationManager = CLLocationManager()
    
    private var accessRequestCompletion: AccessRequestBlock?
    private var locationRequestCompletion: LocationRequestBlock?
    
    var isEnabled: Bool { return locationManager.isEnabled }
    
    var canRequestAccess: Bool { return locationManager.canRequestService }
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestAccess(completion: AccessRequestBlock?) {
        accessRequestCompletion = completion
        locationManager.requestWhenInUseAuthorization()
    }
    
    func getLocation(completion: LocationRequestBlock?) {
        locationRequestCompletion = completion
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(manager.authorizationStatus)
        accessRequestCompletion?(isEnabled)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location?.coordinate
        else {
            return
        }
        locationRequestCompletion?(location)
        locationRequestCompletion = nil
        manager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        manager.stopUpdatingLocation()
        locationRequestCompletion?(nil)
        locationRequestCompletion = nil
    }
    
}

extension CLLocationManager {
    var canRequestService: Bool {
        return self.authorizationStatus != .restricted && self.authorizationStatus != .denied
        
    }
    
    var isEnabled: Bool {
        return self.authorizationStatus == .authorizedAlways || self.authorizationStatus == .authorizedWhenInUse
    }
}
