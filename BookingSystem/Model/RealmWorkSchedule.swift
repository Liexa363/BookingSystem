//
//  RealmWorkSchedule.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 21.05.2024.
//

import Foundation
import RealmSwift

class RealmWorkSchedule: Object {
    @Persisted var day: String = ""
    @Persisted var startTime: String = ""
    @Persisted var endTime: String = ""
    @Persisted var interval: String = ""
}

