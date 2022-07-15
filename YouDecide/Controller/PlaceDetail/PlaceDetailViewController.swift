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
    @IBOutlet weak var placeName: UILabel!
    
    var index : Int?
    
    //MARK: - UIViewcontroller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        debugPrint("PlaceDetailVC - viewDidLoad - ")
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
        debugPrint("PlaceDetailVC: prepare: ", sender as? Int ?? 0)
        if (segue.identifier == "showGallery") {
            guard let gallerylVC = segue.destination as? GalleryViewController else {
                debugPrint("segue.destination is not PlaceDetailViewController")
                return
            }
            gallerylVC.index = sender as? Int
        } else if (segue.identifier == "showLocation") {
            guard let locationVC = segue.destination as? LocationViewController else {
                debugPrint("segue.destination is not PlaceDetailViewController")
                return
            }
            locationVC.index = sender as? Int
        }
    }
    
    func updateUI() {
        
        if let index = index {
            debugPrint("PlaceDetailVC - updateUI - ", index)
            let objLocation = appDelegate.arrTravelData[index] as! PlaceDetails
            
            placeName.text = objLocation.name ?? ""
        }
    }
    
    //MARK: - Button click methods

    @IBAction func btnLocationClick(_ sender: Any) {
        // Redirecting to location screen
        self.performSegue(withIdentifier: "showLocation", sender: self.index)
    }
    
    @IBAction func btnGalleryClick(_ sender: Any) {
        // Redirecting to gallery  screen
        self.performSegue(withIdentifier: "showGallery", sender: self.index)
    }
    
}
