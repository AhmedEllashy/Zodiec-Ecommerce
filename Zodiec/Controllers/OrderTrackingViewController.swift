//
//  OrderTrackingViewController.swift
//  Zodiec
//
//  Created by Ahmad Ellashy on 13/12/2023.
//

import UIKit
import MapKit
import CoreLocation

class OrderTrackingViewController: UIViewController {
    //MARK: - @IBOutlets
    @IBOutlet weak var mapView : MKMapView!
    //MARK: - Properties
    var locationManager : CLLocationManager!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocation()

    }

    
 


  

}
//MARK: - Function
extension OrderTrackingViewController {
    func setupLocation(){
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        let status  = locationManager.authorizationStatus
        if status == .denied || status == .notDetermined || status == .authorizedWhenInUse {
            handleErrorAlert("Require Access Location", controller: self)
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        mapView.showsUserLocation = true
    }
}

extension OrderTrackingViewController : CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager!, didUpdateToLocation newLocation: CLLocation!, fromLocation oldLocation: CLLocation!){
        print("\(newLocation.coordinate.latitude) , \(newLocation.coordinate.longitude)")
    }
}
