//
//  User.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 25.04.2024.
//

import Foundation
import RealmSwift

class User {
    var id: String = ""
    var name: String = ""
    var surname: String = ""
    var phone: String = ""
    var photo: String = ""
    var email: String = ""
    var password: String = ""
    var role: String = ""
    var date: String = ""
    
    init(id: String, name: String, surname: String, phone: String, photo: String, email: String, password: String, role: String, date: String) {
        self.id = id
        self.name = name
        self.surname = surname
        self.phone = phone
        self.photo = photo
        self.email = email
        self.password = password
        self.role = role
        self.date = date
    }
}

