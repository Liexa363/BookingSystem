//
//  RealmServiceStation.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 21.05.2024.
//

import Foundation
import RealmSwift

class RealmServiceStation: Object {
    @Persisted var id: String = UUID().uuidString
    @Persisted var name: String = ""
    @Persisted var location: RealmLocation? = RealmLocation()
    @Persisted var services: List<RealmService> = List<RealmService>()
    @Persisted var managerID: String = ""
    @Persisted var workSchedule: List<RealmWorkSchedule> = List<RealmWorkSchedule>()
    @Persisted var feedbackList: List<RealmFeedback> = List<RealmFeedback>()
    @Persisted var masters: List<RealmMasters> = List<RealmMasters>()
}

