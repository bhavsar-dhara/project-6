//
//  HomeViewController.swift
//  YouDecide
//
//  Created by Dhara Bhavsar on 2022-06-20.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cellsPerRow = 0
    
    //MARK: - UIviewcontroller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Fetching data to update the UI
        DataController.instance.getTravelData()
        self.navigationController?.navigationBar.isHidden = true
        
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

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func setupCollectionView() {
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // delete/update from the core data
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
