//
//  PlanViewController.swift
//  DateShare
//
//  Created by KokiHirokawa on 2018/10/20.
//  Copyright © 2018年 Imajin Kawabe. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class PlanViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    var planID: Int!
    var locationManager: CLLocationManager!
    var placesClient: GMSPlacesClient!
    var currentLocation: CLLocationCoordinate2D?
    var currentCameraPosition: GMSCameraPosition?
    var zoomLevel: Float = 15.0
    var mapView: GMSMapView!
    
    let spots: [String:String] = ["ChIJ38WHZwf9KysRUhNblaFnglM": "http://hdk-prod-static-contents.s3.amazonaws.com/uploads/images/posts/20669/thumbnail/tmp/main_f6e60243-891a-4941-b238-fdba8d4cb3d2.jpg", "ChIJwULG5WSOUDERbzafNHyqHZU": "http://hdk-prod-static-contents.s3.amazonaws.com/uploads/images/posts/20669/thumbnail/tmp/main_f6e60243-891a-4941-b238-fdba8d4cb3d2.jpg"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 1.0)
        let mapViewSize = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        mapView = GMSMapView.map(withFrame: mapViewSize, camera: camera)
        mapView.isMyLocationEnabled = true
        mapView.delegate = self
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
        view.addSubview(mapView)
        view.sendSubviewToBack(mapView)
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        placesClient = GMSPlacesClient.shared()
    }
    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last {
//            currentLocation = location.coordinate
//            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
//                                                  longitude: location.coordinate.longitude,
//                                                  zoom: zoomLevel)
//
//            if mapView.isHidden {
//                mapView.isHidden = false
//                mapView.animate(to: camera)
//            } else {
//                mapView.animate(to: camera)
//                calculateElevation(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
//            }
//        }
//    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        currentCameraPosition = position
    }
    
    @IBAction func didPressBackButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
