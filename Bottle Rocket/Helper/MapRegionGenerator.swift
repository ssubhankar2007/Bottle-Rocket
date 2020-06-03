//
//  MapRegionGenerator.swift
//  Bottle Rocket
//
//  Created by Subhankar Ghosh on 31/05/20.
//  Copyright © 2020 Subhankar Ghosh. All rights reserved.
//

import MapKit
import UIKit

protocol MapRegionGenerator: class {
    var locationCoordinate: CLLocationCoordinate2D? { get set }
    var mapKitView: MKMapView { get }
    func setUpRegion(lat: Double, lng: Double)
    func addAnnotation(with title: String, subtitle: String)
    func addAnnotations(from restaurants: [RestaurantInfo])
}

extension MapRegionGenerator where Self: UIViewController {
    
    func setUpRegion(lat: Double, lng: Double) {
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        locationCoordinate = location
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapKitView.setRegion(region, animated: true)
    }
    
    func addAnnotation(with title: String, subtitle: String) {
        let annotation = MKPointAnnotation()
        guard let coordinate = locationCoordinate else { return }
        annotation.coordinate = coordinate
        annotation.title = title
        annotation.subtitle = subtitle
        mapKitView.addAnnotation(annotation)
    }
    
    func addAnnotations(from restaurants: [RestaurantInfo]) {
        if restaurants.isEmpty { return }
        var pointAnnotations = [MKPointAnnotation]()
        
        for restaurant in restaurants {
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = restaurant.coordinate2D
            pointAnnotation.title = restaurant.name
            pointAnnotation.subtitle = restaurant.category
            pointAnnotations.append(pointAnnotation)
        }
        mapKitView.addAnnotations(pointAnnotations)
    }
}
