//
//  YandexMapViewController.swift
//  Task10
//
//  Created by Егор Зайнуллин on 26.06.2022.
//

import UIKit
import YandexMapsMobile

class YandexMapViewController: UIViewController {

    @IBOutlet weak var mapView: YMKMapView!
    
    var currentLocationPoint: YMKPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let mapKit = YMKMapKit.sharedInstance()
        let userLocationLayer = mapKit.createUserLocationLayer(with: mapView.mapWindow)
        userLocationLayer.setVisibleWithOn(true)
        userLocationLayer.isHeadingEnabled = true
        
        mapView.mapWindow.map.move(
                with: YMKCameraPosition.init(target: YMKPoint(latitude: 55.751574, longitude: 37.573856), zoom: 15, azimuth: 0, tilt: 0),
                animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 1),
                cameraCallback: nil)
        
    }

    @IBAction func centerOnLocation(_ sender: Any) {
            let mapKit = YMKMapKit.sharedInstance()
            mapKit.createLocationManager().requestSingleUpdate(withLocationListener: self)
    }
    
    @IBAction func zoomMinus(_ sender: Any) {
        let currentCamera = mapView.mapWindow.map.cameraPosition
        let zoom = currentCamera.zoom / 2
        let target = currentCamera.target
        let azimuth = currentCamera.azimuth
        let tilt = currentCamera.tilt
        
        let newCamera = YMKCameraPosition(target: target, zoom: zoom, azimuth: azimuth, tilt: tilt)
        mapView.mapWindow.map.move(
                with: newCamera,
                animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 1),
                cameraCallback: nil)
    }
    
    @IBAction func zoomPlus(_ sender: Any) {
        let currentCamera = mapView.mapWindow.map.cameraPosition
        let zoom = currentCamera.zoom * 2
        let target = currentCamera.target
        let azimuth = currentCamera.azimuth
        let tilt = currentCamera.tilt
        
        let newCamera = YMKCameraPosition(target: target, zoom: zoom, azimuth: azimuth, tilt: tilt)
        mapView.mapWindow.map.move(
                with: newCamera,
                animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 1),
                cameraCallback: nil)
    }
}


// Это не работает почему-то
extension YandexMapViewController: YMKLocationDelegate {
    func onLocationUpdated(with location: YMKLocation) {
        self.currentLocationPoint = location.position
        print("Position is updated")
    }
    
    func onLocationStatusUpdated(with status: YMKLocationStatus) {
        
    }
    
    
}
