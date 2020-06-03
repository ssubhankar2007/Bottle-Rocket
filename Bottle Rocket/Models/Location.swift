//
//  Location.swift
//  Bottle Rocket
//
//  Created by Subhankar Ghosh on 30/05/20.
//  Copyright © 2020 Subhankar Ghosh. All rights reserved.
//

import Foundation

struct Location: Decodable {
    let address: String
    let crossStreet: String?
    let lat: Double
    let lng: Double
    let postalCode: String?
    let cc: String
    let city: String
    let state: String
    let country: String
    let formattedAddress: [String]
}
