//
//  RealmCar.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 28.04.2024.
//

import Foundation
import RealmSwift

class RealmCar: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var brand: String = ""
    @Persisted var model: String = ""
    @Persisted var year: String = ""
    @Persisted var bodyType: String = ""
    @Persisted var fuel: String = ""
    @Persisted var engineCapacity: String = ""
    @Persisted var transmission: String = ""
    @Persisted var color: String = ""
    @Persisted var registrationNumber: String = ""
    @Persisted var ownerID: String = ""
}

