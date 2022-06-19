//
//  DataManager.swift
//  YouDecide
//
//  Created by Dhara Bhavsar on 2022-06-18.
//

import Foundation

class UserDataManager {
    
    static var instance = UserDataManager()
    
    func saveIntoUserDefault() {
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: appDelegate.arrPlaces)
        userDefaults.set(encodedData, forKey: "PlaceInfo")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            userDefaults.synchronize()
        }
    }
    
    func getDataFromUserDefault() {
        let userDefaults = UserDefaults.standard
        let decodedData  = userDefaults.data(forKey: "PlaceInfo")
        if decodedData != nil {
            let decodedPlaces = NSKeyedUnarchiver.unarchiveObject(with: decodedData!) as! [PlaceInfo]
            appDelegate.arrPlaces.removeAll()
            appDelegate.arrPlaces = decodedPlaces
        }
    }
}
