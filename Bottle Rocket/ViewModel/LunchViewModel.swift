//
//  LunchViewModel.swift
//  Bottle Rocket
//
//  Created by Subhankar Ghosh on 30/05/20.
//  Copyright © 2020 Subhankar Ghosh. All rights reserved.
//

import Foundation

class LunchViewModel {
    var restaurentData: RestaurentDetails?
    var apiManager: APIManager?
    var reloadCollection: ()->() = {}
    var imageCache: ImageCache?
    
    init() {
        apiManager = APIManager()
        imageCache = ImageCache(config: .defaultConfig)
        
        DispatchQueue.global().async {
            self.fetchRestaurentDetails {
                self.reloadCollection()
            }
        }
    }

    func fetchRestaurentDetails(completion: @escaping() -> Void) {
        self.apiManager?.fetchRestaurentsData(completionHandler: { [weak self] (result) in
            do {
                if let dataType = try? result.get() {
                    let decoder = JSONDecoder()
                    let data = try decoder.decode(RestaurentDetails.self, from: dataType)
                    self?.restaurentData = data
                    completion()
                }
            } catch (let error as NSError){
                print(error)
            }
        })
    }
}
