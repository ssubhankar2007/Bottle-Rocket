//
//  RestaurentModel.swift
//  Bottle Rocket
//
//  Created by Subhankar Ghosh on 30/05/20.
//  Copyright © 2020 Subhankar Ghosh. All rights reserved.
//

import Foundation

struct RestaurentDetails: Decodable {
    var data: [RestaurantInfo]
    
    enum CodingKeys: String, CodingKey {
        case data = "restaurants"
    }
}

struct RestaurantInfo: Decodable {    
    
    var name: String
    var backgroundImageURL: String
    var category: String
    var contact: Contact?
    var location: Location
}

