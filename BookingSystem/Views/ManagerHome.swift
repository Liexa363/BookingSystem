//
//  ManagerHome.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 26.04.2024.
//

import SwiftUI

struct ManagerHome: View {
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>) {
        self._selectedTab = selectedTab
        self._user = user
    }
    
    let managerTabItems = [
        TabItem(icon: "app.badge.fill", title: "Домашня", tab: .clientHome),
        TabItem(icon: "sparkles.tv", title: "Бронювання", tab: .clientBookingList),
        TabItem(icon: "heart.fill", title: "Про мене", tab: .aboutMe)
    ]
    
    var body: some View {
        VStack {
            
            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab, tabItems: managerTabItems)
            
        }
    }
}

#Preview {
    ManagerHome(selectedTab: .constant(.managerHome), user: .constant(nil))
}
