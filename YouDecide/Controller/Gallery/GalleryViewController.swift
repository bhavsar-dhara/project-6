//
//  GalleryViewController.swift
//  YouDecide
//
//  Created by Dhara Bhavsar on 2022-06-20.
//

import Foundation
import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var addPhotos: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var imagePicker = UIImagePickerController()
    
    var index : Int?
    var objLocation: PlaceDetails?
    var cellsPerRow = 0
    
    //MARK: - UIViewcontroller methods
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupCollectionView()
        
        DataHelper.instance.getTravelData()
        
        objLocation = appDelegate.arrTravelData[index!] as? PlaceDetails
        debugPrint(objLocation?.name ?? "")
//        navItem.title = objLocation.name ?? ""
        collectionView.reloadData()
    }
    
    //MARK: - Button click methods
    
    @IBAction func btnAddPhotos(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
}

extension GalleryViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            ///  Saving selected image into core data
            let obj = appDelegate.arrTravelData[index!] as? PlaceDetails
            let siteName = obj?.name ?? ""
            DataHelper.instance.updateImage(title: siteName, image: image)
            DataHelper.instance.getTravelData()
        }
        collectionView.reloadData()
        picker.dismiss(animated: true, completion: nil);
    }
}

extension GalleryViewController : UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    func setupCollectionView() {
        debugPrint("GalleryVC: setupCollectionView")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsMultipleSelection = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let arrImage = objLocation?.photos as? [UIImage]
        if let arr = arrImage {
            return arr.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryViewCell.reuseIdentifier, for: indexPath as IndexPath) as! GalleryViewCell
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 2.0
        
        let arrImage = objLocation?.photos as? [UIImage]
        cell.img.image = arrImage![indexPath.row]
        return cell
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
