//
//  Contact.swift
//  Bottle Rocket
//
//  Created by Subhankar Ghosh on 30/05/20.
//  Copyright © 2020 Subhankar Ghosh. All rights reserved.
//

import Foundation

struct Contact: Decodable {
    var phoneNumber: String
    var formattedPhone: String
    var twitterHandle: String?
    
    enum CodingKeys: String, CodingKey {
        case phoneNumber = "phone"
        case formattedPhone
        case twitterHandle = "twitter"
    }
}
