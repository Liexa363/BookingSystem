//
//  Service.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 23.04.2024.
//

import Foundation

class Service: ObservableObject, Identifiable {
    var name: String = ""
    var serviceDescription: String = ""
    var price: String = ""
    
    init(name: String, serviceDescription: String, price: String) {
        self.name = name
        self.serviceDescription = serviceDescription
        self.price = price
    }
}

