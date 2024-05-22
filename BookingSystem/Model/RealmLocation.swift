//
//  RealmLocation.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 21.05.2024.
//

import Foundation
import RealmSwift

class RealmLocation: Object {
    @Persisted var country: String = ""
    @Persisted var city: String = ""
    @Persisted var street: String = ""
    @Persisted var houseNumber: String = ""
}

