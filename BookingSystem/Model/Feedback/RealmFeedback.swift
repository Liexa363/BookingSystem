//
//  RealmFeedback.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 27.05.2024.
//

import Foundation
import RealmSwift

class RealmFeedback: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var rating: String = ""
    @Persisted var text: String = ""
    @Persisted var date: String = ""
    @Persisted var author: String = ""
    @Persisted var serviceStationID: String = ""
}
