//
//  RealmService.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 21.05.2024.
//

import Foundation
import RealmSwift

class RealmService: Object {
    @Persisted var name: String = ""
    @Persisted var serviceDescription: String = ""
    @Persisted var price: String = ""
}

