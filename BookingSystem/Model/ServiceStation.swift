//
//  ServiceStation.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 23.04.2024.
//

import Foundation

struct ServiceStation {
    var name: String
    var photos: [String]
    var location: Location
    var services: [Service]
    var manager: User
    var workmans: [User]
    var workSchedule: WorkSchedule
}

