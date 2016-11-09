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
    var people: People?
    
    init(people: People) {
        self.people = people
        if let latitude = people.latitude, let longitude = people.longitude {
            self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            self.coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        }
    }
}

