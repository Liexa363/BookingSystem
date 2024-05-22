//
//  Location.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 23.04.2024.
//

import Foundation

class Location: ObservableObject {
    var country: String = ""
    var city: String = ""
    var street: String = ""
    var houseNumber: String = ""
    
    init(country: String, city: String, street: String, houseNumber: String) {
        self.country = country
        self.city = city
        self.street = street
        self.houseNumber = houseNumber
    }
}

