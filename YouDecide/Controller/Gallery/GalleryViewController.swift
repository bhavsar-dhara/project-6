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
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var imagePicker = UIImagePickerController()
    
    var index : Int?
    
    //MARK: - UIViewcontroller methods
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        DataHelper.instance.getTravelData()
        
        let objLocation = appDelegate.arrTravelData[index!] as! PlaceDetails
//        navItem.title = objLocation.name ?? ""
        
//        let item = UINavigationItem()
//        item.rightBarButtonItem = UIBarButtonItem(title: "Add Photo", style: .plain, target: self, action: #selector(addPhotosTapped))
//        item.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(addTapped))
//        navigationBar.items = [item]
//        navigationBar.topItem?.title = objLocation.name ?? ""
        
        self.collectionView.register(UINib(nibName: "GalleryCell", bundle: nil), forCellWithReuseIdentifier: "GalleryCell")
        collectionView.reloadData()
    }
    
    //MARK: - Button click methods
    
    @objc func addTapped() {
        
        self.navigationController?.popViewController(animated: true)
    }

    @objc func addPhotosTapped() {
        
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let objLocation = appDelegate.arrTravelData[index!] as? PlaceDetails
        let arrImage = objLocation?.photos as? [UIImage]
        if let arr = arrImage {
            return arr.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GalleryCell", for: indexPath) as! GalleryViewCell
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 2.0
        let objLocation = appDelegate.arrTravelData[index!] as? PlaceDetails
        let arrImage = objLocation?.photos as? [UIImage]
        cell.img.image = arrImage![indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 6, height: 100.0)
    }
    
}
