//
//  MasterHome.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 26.04.2024.
//

import SwiftUI

struct MasterHomeView: View {
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>) {
        self._selectedTab = selectedTab
        self._user = user
    }
    
    let masterTabItems = [
        TabItem(icon: "clock", title: "Бронювання", tab: .masterBookingList),
        TabItem(icon: "book.pages", title: "Корисні контакти", tab: .masterUsefulContacts),
        TabItem(icon: "person", title: "Профіль", tab: .aboutMe)
    ]
    
    var body: some View {
        VStack {
            
            switch selectedTab {
            case .masterBookingList:
                Text("BookingList")
                    .font(.title)
            case .masterUsefulContacts:
                Text("UsefulContacts")
                    .font(.title)
            case .aboutMe:
                AboutMeView(selectedTab: $selectedTab, user: $user)
            default:
                Text("Error")
                    .font(.title)
            }
            
            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab, tabItems: masterTabItems)
            
        }
    }
}

#Preview {
    MasterHomeView(selectedTab: .constant(.masterBookingList), user: .constant(nil))
}
