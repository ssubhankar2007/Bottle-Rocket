//
//  RestaurantCollectionViewCell.swift
//  Bottle Rocket
//
//  Created by Subhankar Ghosh on 31/05/20.
//  Copyright © 2020 Subhankar Ghosh. All rights reserved.
//

import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var categoryTypeLabel: UILabel!
    var cellHeight = 180
    var imageCache: ImageCache?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureData(data: RestaurantInfo) {
        restaurantNameLabel.text = data.name
        categoryTypeLabel.text = data.category
        
        if let url = URL(string: data.backgroundImageURL) {
            let image = imageCache?.image(for: url)
            if image == nil {
                let newImage = UIImage()
                newImage.downloadedImage(from: url) { [weak self] (downloadedImage) in
                    DispatchQueue.main.async {
                        self?.backgroundImageView.image = downloadedImage
                    }
                    self?.imageCache?.insertImage(downloadedImage, for: url)
                }
            } else {
                backgroundImageView.image = image
            }
        }
    }
}
