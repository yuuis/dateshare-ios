//
//  PlanRegisterViewController.swift
//  DateShare
//
//  Created by KokiHirokawa on 2018/10/20.
//  Copyright © 2018年 Imajin Kawabe. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class PlanRegisterViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    var locationManager: CLLocationManager!
    var placesClient: GMSPlacesClient!
    var currentLocation: CLLocationCoordinate2D?
    var currentCameraPosition: GMSCameraPosition?
    var zoomLevel: Float = 30.0
    var mapView: GMSMapView!
    var likelyPlaces: [GMSPlace] = []
    
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        currentLocation = location.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        
        if mapView.isHidden {
            mapView.isHidden = false
            mapView.animate(to: camera)
        } else {
            mapView.animate(to: camera)
        }
        
        placesClient.currentPlace(callback: { [weak self] (placeLikelihoods, error) -> Void in
            guard let `self` = self else { return }
            
            if let error = error {
                print("Current Place error: \(error.localizedDescription)")
                return
            }
            
            guard let likelihoodList = placeLikelihoods else { return }
            
            for likelihood in likelihoodList.likelihoods {
                let place = likelihood.place
                self.likelyPlaces.append(place)
            }
        })
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        currentCameraPosition = position
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
