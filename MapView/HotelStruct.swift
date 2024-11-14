//
//  HotelStruct.swift
//  MapView
//
//  Created by Yernar Dyussenbekov on 14.11.2024.
//

import Foundation
import MapKit

struct Hotel {
    var name: String = ""
    var adres: String = ""
    var rating: Float = 0
    var price = 0
    var commentAmount = 0
    var geoLat: CLLocationDegrees = 0
    var geoLong: CLLocationDegrees = 0
    var img = ""
}
