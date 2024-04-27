//
//  ManagerHome.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 26.04.2024.
//

import SwiftUI

struct ManagerHomeView: View {
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>) {
        self._selectedTab = selectedTab
        self._user = user
    }
    
    let managerTabItems = [
        TabItem(icon: "clock", title: "Бронювання", tab: .managerBookingList),
        TabItem(icon: "wrench.adjustable", title: "Про сервіс", tab: .aboutService),
        TabItem(icon: "book.pages", title: "Корисні контакти", tab: .managerUsefulContacts),
        TabItem(icon: "person", title: "Профіль", tab: .aboutMe)
    ]
    
    var body: some View {
        VStack {
            
            switch selectedTab {
            case .managerBookingList:
                Text("BookingList")
                    .font(.title)
            case .aboutService:
                Text("AboutService")
                    .font(.title)
            case .managerUsefulContacts:
                Text("UsefulContacts")
                    .font(.title)
            case .aboutMe:
                AboutMeView(selectedTab: $selectedTab, user: $user)
            default:
                Text("Error")
                    .font(.title)
            }
            
            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab, tabItems: managerTabItems)
            
        }
    }
}

#Preview {
    ManagerHomeView(selectedTab: .constant(.managerBookingList), user: .constant(nil))
}
