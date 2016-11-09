//
//  MapPin.swift
//  PeopleMon
//
//  Created by Riley Osborne on 11/8/16.
//  Copyright © 2016 Riley Osborne. All rights reserved.
//

import MapKit

class MapPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init (coordinate: CLLocationCoordinate2D){
        self.coordinate = coordinate
    }
}
