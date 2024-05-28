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

extension RealmService {
    func toService() -> Service {
        return Service(
            name: self.name,
            serviceDescription: self.serviceDescription,
            price: self.price
        )
    }
}

