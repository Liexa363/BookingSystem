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
    @Binding private var serviceStation: ServiceStation?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>, serviceStation: Binding<ServiceStation?>) {
        self._selectedTab = selectedTab
        self._user = user
        self._serviceStation = serviceStation
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
                ManagerServiceStationView(selectedTab: $selectedTab, user: $user, serviceStation: $serviceStation)
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
    ManagerHomeView(selectedTab: .constant(.managerBookingList), user: .constant(nil), serviceStation: .constant(nil))
}
