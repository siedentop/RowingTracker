//
//  MapPoint.swift
//  RowingTracker
//
//  Created by Christoph Siedentop on 08.06.14.
//  Copyright (c) 2014 Christoph Siedentop. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class MapPoint : NSObject, MKAnnotation {
    var coordinate:CLLocationCoordinate2D
    var title:String?
    
    init(coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(43.07, -89.32), title t:String) {
        self.coordinate = coordinate
        self.title = t
    }
}
