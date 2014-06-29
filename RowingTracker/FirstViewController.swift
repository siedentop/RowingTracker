//
//  FirstViewController.swift
//  RowingTracker
//
//  Created by Christoph Siedentop on 05.06.14.
//  Copyright (c) 2014 Christoph Siedentop. All rights reserved.
//



import UIKit
import CoreLocation
import MapKit

class FirstViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UITextFieldDelegate {
    @IBOutlet var locationTextField : UITextField = nil
    @IBOutlet var worldView : MKMapView = nil
    @IBOutlet var activityIndicator : UIActivityIndicatorView = nil
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        worldView.showsUserLocation = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        locationManager.delegate = nil
    }
    
    func textFieldShouldReturn(textField:UITextField) -> Bool {
        self.findLocation()
        textField.resignFirstResponder()
        return true
    }
    
    func findLocation() {
        locationManager.startUpdatingLocation()
        activityIndicator.startAnimating()
        locationTextField.hidden = true
    }
    
    func foundLocation(loc:CLLocation) {
        let mapPoint = MapPoint(coordinate:loc.coordinate, title:locationTextField.text)
        worldView.addAnnotation(mapPoint)
        let region = MKCoordinateRegionMakeWithDistance(loc.coordinate, 250, 250)
        worldView.setRegion(region, animated:true)
        
        // Reset the UI
        locationTextField.text = ""
        activityIndicator.stopAnimating()
        locationTextField.hidden = false
        locationManager.stopUpdatingLocation()
    }
    
    //#pragma mark - CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: AnyObject[]!) {
        println("Locations: \(locations)")
        
        let newLocation = locations[locations.count-1] as CLLocation
        let time = newLocation.timestamp.timeIntervalSinceNow
        
        if time < -180 {
            return
        }
        
        self.foundLocation(newLocation)
    }
    
    //#pragma mark - MKMapViewDelegate
    func mapView(mapView:MKMapView, didUpdateUserLocation userLocation:MKUserLocation) {
        let loc = userLocation.coordinate
        let region = MKCoordinateRegionMakeWithDistance(loc, 250, 250)
        worldView.setRegion(region, animated:true)
    }
    
    
}


