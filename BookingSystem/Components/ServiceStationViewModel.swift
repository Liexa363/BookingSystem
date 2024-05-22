//
//  ServiceStationViewModel.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 21.05.2024.
//

import SwiftUI
import Combine

class ServiceStationViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var location: Location = Location(country: "", city: "", street: "", houseNumber: "")
    @Published var services: [Service] = [Service(name: "", serviceDescription: "", price: "")]
    @Published var managerID: String = ""
    @Published var workSchedule: [WorkSchedule] = [WorkSchedule(day: "", startTime: "", endTime: "")]
}

