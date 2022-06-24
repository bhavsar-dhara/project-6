//
//  PlaceDetailViewController.swift
//  YouDecide
//
//  Created by Dhara Bhavsar on 2022-06-20.
//

import Foundation
import UIKit

class PlaceDetailViewController: UIViewController {

    @IBOutlet weak var navigationBar: UINavigationBar!
    
    var dataController: DataController!
    var index : Int?
    
    //MARK: - UIViewcontroller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let objLocation = appDelegate.arrTravelData[index!] as! PlaceDetails

        let item = UINavigationItem()
        item.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(addTapped))
        navigationBar.items = [item]
        navigationBar.topItem?.title = objLocation.name ?? ""
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
