//
//  PlaceCoordinates.swift
//  YouDecide
//
//  Created by Dhara Bhavsar on 2022-06-18.
//

import Foundation

class PlaceCordinates : NSObject, NSCoding {
    
    var latitude : Double? = nil
    var longitude : Double? = nil
    
    init(latitude: Double, longitude: Double) {
        
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func encode(with encoder: NSCoder) {
        
        encoder.encode(latitude, forKey: "latitude")
        encoder.encode(longitude, forKey: "longitude")
    }
    
    required convenience init?(coder decoder: NSCoder) {
        
        let lat = decoder.decodeObject(forKey: "latitude") as! Double
        let long = decoder.decodeObject(forKey: "longitude") as! Double
        self.init(latitude: lat, longitude: long)
    }
}
