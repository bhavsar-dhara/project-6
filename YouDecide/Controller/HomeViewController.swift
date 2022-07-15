//
//  HomeViewController.swift
//  YouDecide
//
//  Created by Dhara Bhavsar on 2022-06-20.
//

import Foundation
import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataController: DataController?
    var cellsPerRow = 0
    
    private var locationManager: CLLocationManager!
    private var lat = 0.0
    private var long = 0.0
    
    //MARK: - UIviewcontroller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        debugPrint("HomeVC")
        // initialize collection view
        setupCollectionView()
        
        // Requesting permission for location
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }

        // Fetching data to update the UI
        DataHelper.instance.getTravelData()
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        DataHelper.instance.getTravelData()
        collectionView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        debugPrint("HomeVC: prepare: ", sender as? Int ?? 0)
        if (segue.identifier == "showDetail") {
            guard let placeDetailVC = segue.destination as? PlaceDetailViewController else {
                debugPrint("segue.destination is not PlaceDetailViewController")
                return
            }
            placeDetailVC.index = sender as? Int
        }
    }

    //MARK: - Button click methods
    
    @IBAction func btnAddPlaceClick(_ sender: Any) {
        
        debugPrint("btnAddPlaceClick")
        
        // Presenting alert to enter place name
        let alert = UIAlertController(title: "Travel diaries", message: "Enter place name", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Plese enter name here"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            print("Text field: \(textField!.text!)")
            self.savePlace(title: textField!.text!, lat: self.lat, long: self.long)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        
        debugPrint("btnBack")
        exit(0)
    }
    
    //MARK: - Custom methods
    
    func savePlace(title : String, lat: Double, long: Double) {
        
        // Saving name and fetching data to update the UI
        DataHelper.instance.savePlaceName(name: title, lat: lat, long: long)
        DataHelper.instance.getTravelData()
        collectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setupCollectionView() {
        debugPrint("HomeVC: setupCollectionView")
        // Set up Collection View
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
    }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.arrTravelData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Initializing collection view cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewCell.reuseIdentifier, for: indexPath as IndexPath) as! HomeViewCell
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 2.0
        let objEntity = appDelegate.arrTravelData[indexPath.row] as? PlaceDetails
        debugPrint("objEntity = ", objEntity?.name ?? "")
        cell.placeLabel.text = objEntity?.name ?? ""
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // show the place details view
        self.performSegue(withIdentifier: "showDetail", sender: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left + flowLayout.sectionInset.right + (flowLayout.minimumInteritemSpacing * CGFloat(cellsPerRow - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(cellsPerRow))
        return CGSize(width: size, height: size)
    }
    
    override func viewWillLayoutSubviews() {
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        if UIDevice.current.orientation == .portrait {
            cellsPerRow = 3
        } else {
            cellsPerRow = 5
        }
        flowLayout.invalidateLayout()
    }
}

extension HomeViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            lat = location.coordinate.latitude
            long = location.coordinate.longitude
        }
    }
}
