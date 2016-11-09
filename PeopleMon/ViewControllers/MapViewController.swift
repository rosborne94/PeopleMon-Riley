//
//  MapViewController.swift
//  PeopleMon
//
//  Created by Riley Osborne on 11/7/16.
//  Copyright © 2016 Riley Osborne. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let updatingLocation = true
    let latitudeDelta = 0.2
    let longitudeDelta = 0.2
    
    var annotations: [MapPin] = []
    var overlay: MKOverlay?

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.showsUserLocation = true
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !WebServices.shared.userAuthTokenExists() || WebServices.shared.userAuthTokenExpired() {
            performSegue(withIdentifier: "PresentLoginNoAnimation", sender: self)
        } 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func logoutTapped(_ sender: Any) {
        UserStore.shared.logout {
            self.performSegue(withIdentifier: "PresentLogin", sender: self)
        }
    }
   
}

//MARK: - CLLocationManagerDelegte
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpanMake(latitudeDelta, longitudeDelta))
        mapView.setRegion(region, animated: true)
    }
}
//MARK: - MKMapViewController
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let reuseID = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            pinView!.canShowCallout = false
            pinView!.animatesDrop = false
            } else {
            pinView!.annotation =  annotation
        }
    return pinView
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        self.overlay = overlay
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = #colorLiteral(red: 0, green: 0.32836169, blue: 1, alpha: 1)
        renderer.lineWidth = 5.0
        renderer.lineCap = .round
        return renderer
    }
}


