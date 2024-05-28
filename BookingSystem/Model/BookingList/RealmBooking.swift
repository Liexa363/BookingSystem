//
//  RealmBookingList.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 24.05.2024.
//

import Foundation
import RealmSwift

class RealmBooking: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var date: String = ""
    @Persisted var time: String = ""
    @Persisted var serviceStationID: String = ""
    @Persisted var clientID: String = ""
    @Persisted var service: RealmService?
}

