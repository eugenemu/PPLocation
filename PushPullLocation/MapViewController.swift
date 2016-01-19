//
//  MapViewController.swift
//  PushPullLocation
//
//  Created by Eugene Mu on 1/18/16.
//  Copyright © 2016 Eugene Mu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, CancelButtonDelegate {

    let locationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
//    @IBAction func refreshButton(sender: UIBarButtonItem) {
//        let lat = locationManager.location?.coordinate.latitude
//        let long = locationManager.location?.coordinate.longitude
//        print("\(lat) \(long)")
//    }
    
    @IBAction func yourLocation(sender: UIBarButtonItem) {
        
    }
    
    @IBAction func pushLocation(sender: UIBarButtonItem) {
        let coordinates = mapView.userLocation.coordinate
        let coordinateArray = [coordinates.latitude, coordinates.longitude]
        print(coordinateArray)
        Connection.sharedInstance.sendToServer(coordinateArray)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Before Locations")
        print(locations)
        print("After the locations")
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .AuthorizedAlways)
    }

    func cancelButtonPressedFrom(controller: UIViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = MKUserTrackingMode.Follow
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

