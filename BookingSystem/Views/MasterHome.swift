//
//  MasterHome.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 26.04.2024.
//

import SwiftUI

struct MasterHome: View {
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>) {
        self._selectedTab = selectedTab
        self._user = user
    }
    
    let masterTabItems = [
        TabItem(icon: "app.badge.fill", title: "Домашня", tab: .clientHome),
        TabItem(icon: "sparkles.tv", title: "Бронювання", tab: .clientBookingList),
        TabItem(icon: "heart.fill", title: "Про мене", tab: .aboutMe)
    ]
    
    var body: some View {
        VStack {
            
            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab, tabItems: masterTabItems)
            
        }
    }
}

#Preview {
    MasterHome(selectedTab: .constant(.masterHome), user: .constant(nil))
}
