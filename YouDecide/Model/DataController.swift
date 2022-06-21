//
//  DataController.swift
//  YouDecide
//
//  Created by Dhara Bhavsar on 2022-06-19.
//

import Foundation
import CoreData
import UIKit

// core data controller class

class DataController {
    
    static var instance : DataController = DataController()
    
    // To save place/location name into core data
    func savePlaceName(name : String) {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let objEntityLocation = NSEntityDescription.insertNewObject(forEntityName: "PlaceDetails", into: managedContext) as! PlaceDetails
        
        objEntityLocation.name = name
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save the place name. \(error), \(error.userInfo)")
        }
    }
    
    // To update place's lat and long values into coredata as per phone's device location
    func updatePlaceLocation(title : String, lat : Double, long : Double) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaceDetails")
        fetchRequest.predicate = NSPredicate(format: "name = %@", title)
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            let res = try managedContext.fetch(fetchRequest)
            if let arr =  res as? [NSManagedObject] {
                if arr.count != 0 {
                    let managedObject = arr[0]
                    let obj = managedObject as! PlaceDetails
                    obj.latitude = lat
                    obj.longitude = long
                    try managedContext.save()
                }
            }
        } catch let error as NSError {
            print("Could not fetch the place location. \(error), \(error.userInfo)")
        }
    }
    
    // To update image in core data as per place
    func updateImage(title : String, image : UIImage) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PlaceDetails")
        fetchRequest.predicate = NSPredicate(format: "name = %@", title)
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            let res = try managedContext.fetch(fetchRequest)
            if let arr =  res as? [NSManagedObject] {
                if arr.count != 0 {
                    let managedObject = arr[0]
                    let obj = managedObject as! PlaceDetails
                    if obj.photos == nil {
                        var arrImg : [UIImage] = []
                        arrImg.append(image)
                        obj.photos = arrImg as NSObject
                    } else {
                        var arrImg = obj.photos as! [UIImage]
                        arrImg.append(image)
                        obj.photos = arrImg as NSObject
                    }
                    try managedContext.save()
                }
            }
        } catch let error as NSError {
            print("Could not fetch the place details. \(error), \(error.userInfo)")
        }
    }
    
    // To get travel data from core data and store into array
    func getTravelData() {
        
        appDelegate.arrTravelData.removeAll()
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PlaceDetails")
        
        do {
            appDelegate.arrTravelData = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch the complete travel data. \(error), \(error.userInfo)")
        }
    }
}
