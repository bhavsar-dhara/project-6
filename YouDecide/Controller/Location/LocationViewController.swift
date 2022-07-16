//
//  LocationViewController.swift
//  YouDecide
//
//  Created by Dhara Bhavsar on 2022-06-20.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class LocationViewController: UIViewController {
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var map: MKMapView!
    
    var index : Int?
    var locationEntity: PlaceDetails?
    
    private let span = MKCoordinateSpan.init(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    private var locationManager: CLLocationManager!
    
    //MARK: - UIViewcontroller methods
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpInitialUI()
        setUpMap()
    }
    
    //MARK: - Custom methods

    private func setUpInitialUI() {
        
        locationEntity = appDelegate.arrTravelData[index!] as? PlaceDetails
//        navItem.title = "\(locationEntity.name ?? "")'s Location"
        
//        let item = UINavigationItem()
//        item.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(addTapped))
//        if locationEntity.latitude == 0.0 {
//            item.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped))
//        }
//        navigationBar.items = [item]
//
//        navigationBar.topItem?.title = "\(locationEntity.name ?? "")'s Location"
    }
    
    private func setUpMap() {
        
        locationEntity = appDelegate.arrTravelData[index!] as? PlaceDetails
        let coordinate = CLLocationCoordinate2D(latitude: locationEntity!.latitude , longitude: locationEntity!.longitude)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        let region = MKCoordinateRegion.init(center: coordinate, span: span)
        map.setRegion(region, animated: true)
        map.addAnnotation(annotation)
        
        if locationEntity!.latitude == 0.0 {
            /// Requesting permission for location
            if (CLLocationManager.locationServicesEnabled()) {
                locationManager = CLLocationManager()
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.requestAlwaysAuthorization()
                locationManager.startUpdatingLocation()
            }
        } else {
            print("Place pin is already stored")
        }
    }    
}

extension LocationViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.map.setRegion(region, animated: true)
            
            let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            map.addAnnotation(annotation)
        }
    }
}
