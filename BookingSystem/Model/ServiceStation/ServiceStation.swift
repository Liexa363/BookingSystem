//
//  ServiceStation.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 23.04.2024.
//

import Foundation
import SwiftUI

struct ServiceStation {
    var id: String = ""
    var name: String = ""
    var location: Location = Location(country: "", city: "", street: "", houseNumber: "")
    var services: [Service] = [Service(name: "", serviceDescription: "", price: "")]
    var managerID: String = ""
    var workSchedule: [WorkSchedule] = [WorkSchedule(day: "", startTime: "", endTime: "", interval: "")]
    var feedbackList: [Feedback] = [Feedback(id: "", rating: "", text: "", date: "", author: "", serviceStationID: "")]
    var masters: [Masters] = [Masters(serviceStationID: "", masterEmail: "")]
    
    init(id: String, name: String, location: Location, services: [Service], managerID: String, workSchedule: [WorkSchedule], feedbackList: [Feedback], masters: [Masters]) {
        self.id = id
        self.name = name
        self.location = location
        self.services = services
        self.managerID = managerID
        self.workSchedule = workSchedule
        self.feedbackList = feedbackList
        self.masters = masters
    }
}

