//
//  User.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 23.04.2024.
//

import Foundation
import RealmSwift

class RealmUser: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var name: String = ""
    @Persisted var surname: String = ""
    @Persisted var phone: String = ""
    @Persisted var photo: String = ""
    @Persisted var email: String = ""
    @Persisted var password: String = ""
    @Persisted var role: String = ""
    @Persisted var date: String = ""
}

