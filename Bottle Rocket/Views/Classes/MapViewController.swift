//
//  MapViewController.swift
//  Bottle Rocket
//
//  Created by Subhankar Ghosh on 31/05/20.
//  Copyright © 2020 Subhankar Ghosh. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MapRegionGenerator {
    @IBOutlet weak var mapView: MKMapView!
    
    private let identifier = "annotationId"
    var restaurantDetails: RestaurentDetails?
    var locationCoordinate: CLLocationCoordinate2D?
    var mapKitView = MKMapView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapKitView = mapView
        guard let data = restaurantDetails?.data.first else { return }
        setUpRegion(lat: data.location.lat, lng: data.location.lng)
        addAnnotations(from: restaurantDetails?.data ?? [RestaurantInfo]())
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
}

