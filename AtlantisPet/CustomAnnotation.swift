//
//  CustomAnnotation.swift
//  AtlantisPet
//
//  Created by Seyhun Koçak on 4.05.2023.
//

import Foundation
import MapKit


class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?) {
        self.coordinate = coordinate
        self.title = title
    }
}
