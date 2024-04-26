//
//  BookingSystemApp.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 23.04.2024.
//

import SwiftUI

@main
struct BookingSystemApp: App {
    
    @StateObject private var realmManager = RealmManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(realmManager)
        }
    }
}
