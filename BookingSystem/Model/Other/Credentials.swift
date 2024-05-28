//
//  Credentials.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 25.04.2024.
//

import Foundation
import RealmSwift

class Credentials: Object {
    @Persisted var email: String = ""
    @Persisted var password: String = ""
    @Persisted var role: String = ""
}

