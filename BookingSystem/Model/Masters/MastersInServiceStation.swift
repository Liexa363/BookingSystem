//
//  MastersInServiceStation.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 28.05.2024.
//

import Foundation

struct Masters {
    var serviceStationID: String = ""
    var masterEmail: String = ""
    
    init(serviceStationID: String, masterEmail: String) {
        self.serviceStationID = serviceStationID
        self.masterEmail = masterEmail
    }
}

