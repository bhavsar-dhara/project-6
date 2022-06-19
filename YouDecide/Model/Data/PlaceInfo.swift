//
//  PlaceInfo.swift
//  YouDecide
//
//  Created by Dhara Bhavsar on 2022-06-18.
//

import Foundation

class PlaceInfo : NSObject, NSCoding {
    
    var placeTitle : String? = nil
    var placeLocation : PlaceCordinates? = nil
    var photos : [Data]? = nil
    
    init(placeTitle: String, placeLocation: PlaceCordinates?, photos: [Data]?) {
        
        self.placeTitle = placeTitle
        self.placeLocation = placeLocation
        self.photos = photos
    }
    
    func encode(with encoder: NSCoder) {
        
        encoder.encode(placeTitle, forKey: "placeTitle")
        encoder.encode(placeLocation, forKey: "placeLocation")
        encoder.encode(photos, forKey: "photos")
    }
    
    required convenience init?(coder decoder: NSCoder) {
        
        let id = decoder.decodeObject(forKey: "placeTitle") as! String
        let name = decoder.decodeObject(forKey: "placeLocation") as? PlaceCordinates
        let shortname = decoder.decodeObject(forKey: "photos") as? [Data]
        self.init(placeTitle: id, placeLocation: name, photos: shortname)
    }
}
