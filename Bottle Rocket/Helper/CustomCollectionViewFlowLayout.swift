//
//  CustomCollectionViewFlowLayout.swift
//  Bottle Rocket
//
//  Created by Subhankar Ghosh on 31/05/20.
//  Copyright © 2020 Subhankar Ghosh. All rights reserved.
//

import UIKit

protocol CollectionItemSize {
    var itemWidth: CGFloat { get set }
    var itemHeight: CGFloat { get set }
}

class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout, CollectionItemSize {
        
    var itemWidth: CGFloat = 0.0
    var itemHeight: CGFloat = 0.0
    var cellHeight: CGFloat = 180
    
    var display: CollectionDisplay = .list {
        didSet {
            if display != oldValue {
                self.invalidateLayout()
            }
        }
    }
    
    var containerWidth: CGFloat = 0.0 {
        didSet {
            if containerWidth != oldValue {
                self.invalidateLayout()
            }
        }
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        self.configLayout()
    }
    
    convenience init(display: CollectionDisplay, containerWidth: CGFloat, lineSpace: CGFloat = 10, interItemSpace: CGFloat = 10) {
        self.init()
        self.display = display
        self.containerWidth = containerWidth
        self.minimumLineSpacing = lineSpace
        self.minimumInteritemSpacing = interItemSpace
        self.configLayout()
    }
        
    func configLayout() {
        switch display {
        case .inline:
            self.scrollDirection = .horizontal
            guard let collectionView = collectionView else { return }
            if self.itemHeight > 0 && self.itemWidth > 0 {
                self.itemSize = CGSize(width: collectionView.frame.width * itemWidth, height: itemHeight)
            } else {
                self.itemSize = CGSize(width: collectionView.frame.width * 0.9, height: 300)
            }
            
        case .grid(let column):
            self.scrollDirection = .vertical
            let spacing = CGFloat(column - 1) * minimumLineSpacing
            let width = (containerWidth - spacing) / CGFloat(column)
            self.itemSize = CGSize(width: width, height: width)
            
        case .list:
            self.scrollDirection = .vertical
            self.itemSize = CGSize(width: containerWidth, height: cellHeight)
        }
    }
}
