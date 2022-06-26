//
//  ViewController.swift
//  Task10
//
//  Created by Егор Зайнуллин on 25.06.2022.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = LocationManager.shared
    
    var currentLocation: CLLocationCoordinate2D?
    
    var places = [
        Place(coord: CLLocationCoordinate2D(latitude: 59.9340840311751, longitude: 30.3061486809257), name: "St Isaac Cathedral", image: "st_isaac"),
        Place(coord: CLLocationCoordinate2D(latitude: 62.0667, longitude: 35.233299), name: "Kizhi", image: "kizhi")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.requestAccess { [weak self]
            isEnabled in
            if isEnabled {
                self?.locationManager.getLocation { [weak self] location in
                    if let location = location
                    {
                        self?.currentLocation = location
                    }
                }
            }
        }
        mapView.delegate = self
        mapView.addAnnotations(places)
    }
    
    func zoom(delta: CGFloat) {
        let currentCamera = mapView.camera
        let newCamera = MKMapCamera(lookingAtCenter: currentCamera.centerCoordinate, fromDistance: currentCamera.altitude * delta, pitch: currentCamera.pitch, heading: currentCamera.heading)
        mapView.setCamera(newCamera, animated: true)
    }
    
    @IBAction func zoomPlus(_ sender: Any) {
        zoom(delta: 0.5)
    }
    
    @IBAction func zoomMinus(_ sender: Any) {
        zoom(delta: 2.0)
        
    }
    @IBAction func centerLocation(_ sender: Any) {
        let currentCamera = mapView.camera
        let newCamera = MKMapCamera(lookingAtCenter: mapView.userLocation.coordinate, fromDistance: currentCamera.altitude, pitch: currentCamera.pitch, heading: currentCamera.heading)
        mapView.setCamera(newCamera, animated: true)
    }
}

class Place: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    var imageName: String = ""
    
    var placeName = ""
    
    init(coord: CLLocationCoordinate2D, name: String, image: String) {
        coordinate = coord
        imageName = image
        placeName = name
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let av = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationView") ?? MKAnnotationView()
        if let a = annotation as? Place {
            let image = UIImage(named: a.imageName)?.resize(maxWidthHeight: 40)
            av.image = image
        }
        return av
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let place = view.annotation as? Place {
            print(place.placeName)
            mapView.deselectAnnotation(place, animated: true)
        }
    }
}

extension UIImage {

    func resize(maxWidthHeight : Double)-> UIImage? {

        let actualHeight = Double(size.height)
        let actualWidth = Double(size.width)
        var maxWidth = 0.0
        var maxHeight = 0.0

        if actualWidth > actualHeight {
            maxWidth = maxWidthHeight
            let per = (100.0 * maxWidthHeight / actualWidth)
            maxHeight = (actualHeight * per) / 100.0
        }else{
            maxHeight = maxWidthHeight
            let per = (100.0 * maxWidthHeight / actualHeight)
            maxWidth = (actualWidth * per) / 100.0
        }

        let hasAlpha = true
        let scale: CGFloat = 0.0

        UIGraphicsBeginImageContextWithOptions(CGSize(width: maxWidth, height: maxHeight), !hasAlpha, scale)
        self.draw(in: CGRect(origin: .zero, size: CGSize(width: maxWidth, height: maxHeight)))

        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }

}
