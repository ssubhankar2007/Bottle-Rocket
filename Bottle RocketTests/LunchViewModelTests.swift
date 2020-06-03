//
//  LunchViewModelTests.swift
//  Bottle RocketTests
//
//  Created by Subhankar Ghosh on 01/06/20.
//  Copyright © 2020 Subhankar Ghosh. All rights reserved.
//

import XCTest
@testable import Bottle_Rocket


private let mockLocation = Location(address: "5100 Belt Line Road, STE 502", crossStreet: "Dallas North Tollway", lat: 32.950787, lng: -96.821118, postalCode: "75254", cc: "US", city: "Addison", state: "TX", country: "United States", formattedAddress: ["5100 Belt Line Road, STE 502 (Dallas North Tollway)", "Addison, TX 75254", "United States"])
private let mockContact = Contact(phoneNumber: "9723872337", formattedPhone: "(972) 387-2337", twitterHandle: "hopdoddy")
private let mockRestaurant = RestaurantInfo(name: "Hopdoddy Burger Bar", backgroundImageURL:  "http://sandbox.bottlerocketapps.com/BR_iOS_CodingExam_2015_Server/Images/hopdoddy.png", category: "Burgers", contact: mockContact, location: mockLocation)
private let mockRestaurants = RestaurentDetails(data: [mockRestaurant])

class LunchViewModelTests: XCTestCase {
    
    func testViewModel() {
        let viewModel = LunchViewModel()
        let data = loadDataFromBundle("RestaurantDetailResponseMock", fileExtension: "json")
        do {
            let decoder = JSONDecoder()
            let newData = try decoder.decode(RestaurentDetails.self, from: data)
            viewModel.restaurentData = newData
            XCTAssertNotNil(viewModel.restaurentData)
            XCTAssertEqual(mockRestaurant.backgroundImageURL, viewModel.restaurentData?.data.first?.backgroundImageURL)
            XCTAssertEqual(mockContact.phoneNumber, viewModel.restaurentData?.data.first?.contact?.phoneNumber)
            XCTAssertNotEqual(viewModel.restaurentData?.data[1].contact?.phoneNumber, mockContact.phoneNumber)
        } catch (let error as NSError) {
            print(error)
        }
    }
}

