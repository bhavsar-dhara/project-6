//
//  PlaceDetailViewController.swift
//  YouDecide
//
//  Created by Dhara Bhavsar on 2022-06-20.
//

import Foundation
import UIKit

class PlaceDetailViewController: UIViewController {

    @IBOutlet weak var navItem: UINavigationItem!
    
    var index : Int? {
        didSet {
            debugPrint("PlaceDetailVC - index - ")
            updateUI()
            
        }
    }
    
    //MARK: - UIViewcontroller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        debugPrint("PlaceDetailVC - viewDidLoad - ")
        updateUI()
    }
    
    func updateUI() {
        // https://stackoverflow.com/questions/51967571/cant-pass-data-via-segue
        // this method is being called twice now - TODO
        if let index = index {
            debugPrint("PlaceDetailVC - updateUI - ", index)
            let objLocation = appDelegate.arrTravelData[index] as! PlaceDetails
            
            navItem.title = objLocation.name ?? ""
        }
    }
    
    //MARK: - Button click methods
    
    @objc func addTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnLocationClick(_ sender: Any) {
        // Redirecting to location screen
//        let locationVC = LocationVC(nibName: "LocationVC", bundle: nil)
//        locationVC.index = index
//        self.navigationController?.pushViewController(locationVC, animated: true)
        
    }
    
    @IBAction func btnGalleryClick(_ sender: Any) {
        // Redirecting to gallery  screen
//        let galleryVC = GalleryVC(nibName: "GalleryVC", bundle: nil)
//        galleryVC.index = index
//        self.navigationController?.pushViewController(galleryVC, animated: true)
    }
    
}
