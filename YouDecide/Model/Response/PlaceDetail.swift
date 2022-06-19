//
//  PlaceDetail.swift
//  YouDecide
//
//  Created by Dhara Bhavsar on 2022-06-18.
//

import Foundation

struct PlaceDetail : Codable {
    
    let placeTitle : String?
    let placeLocation : PlaceLocation?
    let photos : [String]?

    enum CodingKeys: String, CodingKey {

        case placeTitle = "placeTitle"
        case placeLocation = "placeLocation"
        case photos = "photos"
    }

    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        placeTitle = try values.decodeIfPresent(String.self, forKey: .placeTitle)
        placeLocation = try values.decodeIfPresent(PlaceLocation.self, forKey: .placeLocation)
        photos = try values.decodeIfPresent([String].self, forKey: .photos)
    }
}
