//
//  RealmMastersInServiceStation.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 28.05.2024.
//

import Foundation
import RealmSwift

class RealmMasters: Object {
    @Persisted var serviceStationID: String = ""
    @Persisted var masterEmail: String = ""
}

