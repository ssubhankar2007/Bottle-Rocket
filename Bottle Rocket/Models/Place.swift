//
//  Place.swift
//  Bottle Rocket
//
//  Created by Subhankar Ghosh on 31/05/20.
//  Copyright © 2020 Subhankar Ghosh. All rights reserved.
//

import Foundation
import MapKit

protocol Place {
    var mainTitle: String { get }
    var detailTitle: String { get }
    var coordinate2D: CLLocationCoordinate2D { get }
}

extension RestaurantInfo: Place {
    var mainTitle: String {
        name
    }
    var detailTitle: String {
        category
    }
    var coordinate2D: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: location.lat, longitude: location.lng)
    }
}
