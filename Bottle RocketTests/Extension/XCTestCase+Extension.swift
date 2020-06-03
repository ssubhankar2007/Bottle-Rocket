//
//  XCTestCase+Extension.swift
//  Bottle RocketTests
//
//  Created by Subhankar Ghosh on 01/06/20.
//  Copyright © 2020 Subhankar Ghosh. All rights reserved.
//

import XCTest

extension XCTestCase {
    
    func loadDataFromBundle(_ fileName: String, fileExtension: String) -> Data {
        let testBundle = Bundle(for: classForCoder)
        guard let filePath = testBundle.path(forResource: fileName, ofType: fileExtension) else {
            fatalError("Can't find file path")
        }
        guard let data = FileManager.default.contents(atPath: filePath) else {
            fatalError("Can't get data from local source")
        }
        return data
    }
}
