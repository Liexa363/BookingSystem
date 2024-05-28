//
//  Car.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 23.04.2024.
//

import Foundation

struct Car {
    var id: String = ""
    var brand: String = ""
    var model: String = ""
    var year: String = ""
    var bodyType: String = ""
    var fuel: String = ""
    var engineCapacity: String = ""
    var transmission: String = ""
    var color: String = ""
    var registrationNumber: String = ""
    var ownerID: String = ""
    
    init(id: String, brand: String, model: String, year: String, bodyType: String, fuel: String, engineCapacity: String, transmission: String, color: String, registrationNumber: String, ownerID: String) {
        self.id = id
        self.brand = brand
        self.model = model
        self.year = year
        self.bodyType = bodyType
        self.fuel = fuel
        self.engineCapacity = engineCapacity
        self.transmission = transmission
        self.color = color
        self.registrationNumber = registrationNumber
        self.ownerID = ownerID
    }
}

