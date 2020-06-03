//
//  CollectionDisplay.swift
//  Bottle Rocket
//
//  Created by Subhankar Ghosh on 31/05/20.
//  Copyright © 2020 Subhankar Ghosh. All rights reserved.
//

import Foundation

enum CollectionDisplay {
    /// Horizontal Layout
    case inline
    /// One item per row
    case list
    /// More than one item per row
    case grid(columns: Int)
}

extension CollectionDisplay: Equatable {
    
    public static func == (lhs: CollectionDisplay, rhs: CollectionDisplay) -> Bool {
        
        switch (lhs, rhs) {
        case (.inline, .inline), (.list, .list):
            return true
            
        case (.grid(let lColumn), .grid(let rColumn)):
            return lColumn == rColumn
            
        default:
            return false
        }
    }
}
