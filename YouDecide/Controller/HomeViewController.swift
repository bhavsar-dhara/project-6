//
//  HomeViewController.swift
//  YouDecide
//
//  Created by Dhara Bhavsar on 2022-06-20.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - UIviewcontroller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Fetching data to update the UI
        DataController.instance.getTravelData()
        self.navigationController?.navigationBar.isHidden = true
        
        // Initiallizing collection view cell
        self.collectionView.register(UINib(nibName: "HomeCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DataController.instance.getTravelData()
        collectionView.reloadData()
    }

    //MARK: - Button click methods
    
    @IBAction func btnAddSiteClick(_ sender: Any) {
        
        // Presenting alert to enter place name
        let alert = UIAlertController(title: "Travel diaries", message: "Enter place name", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Plese enter name here"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            print("Text field: \(textField!.text!)")
            self.savePlace(title: textField!.text!)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Custom methods
    
    func savePlace(title : String) {
        // Saving name and fetching data to update the UI
        DataController.instance.savePlaceName(name: title)
        DataController.instance.getTravelData()
        collectionView.reloadData()
    }
}
