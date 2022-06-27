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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // setting up map
        mapView.mapWindow.map.move(
                with: YMKCameraPosition.init(target: YMKPoint(latitude: 55.751574, longitude: 37.573856), zoom: 15, azimuth: 0, tilt: 0),
                animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5),
                cameraCallback: nil)
        
    }

}
