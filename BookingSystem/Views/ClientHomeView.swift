//
//  ClientHome.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 26.04.2024.
//

import SwiftUI

struct ClientHomeView: View {
    
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>) {
        self._selectedTab = selectedTab
        self._user = user
    }
    
    let clientTabItems = [
        TabItem(icon: "house", title: "Домашня", tab: .clientHome),
        TabItem(icon: "heart.fill", title: "Улюблені", tab: .clientFavorites),
        TabItem(icon: "clock", title: "Бронювання", tab: .clientBookingList),
        TabItem(icon: "person", title: "Профіль", tab: .aboutMe)
    ]
    
    var body: some View {
        VStack {
            
            switch selectedTab {
            case .clientHome:
                Text("ClientHome")
                    .font(.title)
            case .clientFavorites:
                Text("ClientFavorites")
                    .font(.title)
            case .clientBookingList:
                Text("ClientBookingList")
                    .font(.title)
            case .aboutMe:
                AboutMeView(selectedTab: $selectedTab, user: $user)
            default:
                Text("Error")
                    .font(.title)
            }
            
            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab, tabItems: clientTabItems)
            
        }
    }
}

#Preview {
    ClientHomeView(selectedTab: .constant(.clientHome), user: .constant(nil))
}
