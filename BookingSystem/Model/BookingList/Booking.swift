//
//  BookingList.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 23.04.2024.
//

import Foundation

struct Booking {
    var id: String
    var date: String
    var time: String
    var serviceStation: ServiceStation
    var client: User
    var service: Service
}

