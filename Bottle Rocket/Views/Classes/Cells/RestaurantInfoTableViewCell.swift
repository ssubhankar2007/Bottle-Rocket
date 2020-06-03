//
//  RestaurantInfoTableViewCell.swift
//  Bottle Rocket
//
//  Created by Subhankar Ghosh on 31/05/20.
//  Copyright © 2020 Subhankar Ghosh. All rights reserved.
//

import UIKit

class RestaurantInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var twitterHandleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureData(restaurantInfo: RestaurantInfo) {
        addressLabel.text = restaurantInfo.location.formattedAddress.joined(separator: ", ")
        phoneNumberLabel.text = restaurantInfo.contact?.formattedPhone
        if let twitter = restaurantInfo.contact?.twitterHandle {
            twitterHandleLabel.text = "@\(twitter)"
        }
    }

}
