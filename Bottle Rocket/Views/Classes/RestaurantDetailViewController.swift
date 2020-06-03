//
//  RestaurentDetailViewController.swift
//  Bottle Rocket
//
//  Created by Subhankar Ghosh on 31/05/20.
//  Copyright © 2020 Subhankar Ghosh. All rights reserved.
//

import UIKit
import MapKit

class RestaurantDetailViewController: UIViewController, MapRegionGenerator {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mkMapView: MKMapView!
    
    var restaurantInformation: RestaurantInfo?
    var allRestaurantsData: RestaurentDetails?
    var locationCoordinate: CLLocationCoordinate2D?
    var mapKitView = MKMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpMapView()
        setUpNavigationBar()
    }
    
    func setUpMapView() {
        mapKitView = mkMapView
        setUpRegion(lat: restaurantInformation?.location.lat ?? 0.0, lng: restaurantInformation?.location.lng ?? 0.0)
        addAnnotation(with: restaurantInformation?.name ?? "", subtitle: restaurantInformation?.category ?? "")
    }
    
    func setUpNavigationBar() {
        navigationItem.title = restaurantInformation?.name
        navigationController?.navigationBar.tintColor = UIColor.init(rgb: 0xFFFFFF)
        let rightBarItem = UIBarButtonItem(image: UIImage(named: "map-marker"), style: .plain, target: self, action: #selector(mapMarkerButtonTapped))
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    @objc func mapMarkerButtonTapped() {
        if let mapVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: Strings.ViewControllerIdentifier.mapViewController) as? MapViewController {
            mapVC.restaurantDetails = allRestaurantsData
            navigationController?.present(mapVC, animated: true)
        }
    }
}

extension RestaurantDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantDetailTableViewCell", for: indexPath) as? RestaurantDetailTableViewCell, let data = restaurantInformation {
                cell.configureData(restaurantInfo: data)
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantInfoTableViewCell", for: indexPath) as? RestaurantInfoTableViewCell, let data = restaurantInformation {
                cell.configureData(restaurantInfo: data)
                return cell
            }
        default:
            break
        }
        return UITableViewCell()
    }
    
    
}
