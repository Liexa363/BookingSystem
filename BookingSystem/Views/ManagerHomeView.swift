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
    @Binding private var selectedBooking: Booking?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>, serviceStation: Binding<ServiceStation?>, selectedBooking: Binding<Booking?>) {
        self._selectedTab = selectedTab
        self._user = user
        self._serviceStation = serviceStation
        self._selectedBooking = selectedBooking
    }
    
    let managerTabItems = [
        TabItem(icon: "clock", title: "Бронювання", tab: .managerBookingList),
        TabItem(icon: "wrench.adjustable", title: "Сервіс", tab: .aboutService),
        TabItem(icon: "bubble", title: "Відгуки", tab: .managerFeedbackList),
        TabItem(icon: "person", title: "Профіль", tab: .aboutMe)
    ]
    
    var body: some View {
        VStack {
            
            switch selectedTab {
            case .managerBookingList:
                ManagerBookingListView(selectedTab: $selectedTab, user: $user, serviceStation: $serviceStation, selectedBooking: $selectedBooking)
            case .aboutService:
                ManagerServiceStationView(selectedTab: $selectedTab, user: $user, serviceStation: $serviceStation)
            case .managerFeedbackList:
                ManagerFeedbackListView(selectedTab: $selectedTab, user: $user, serviceStation: $serviceStation)
            case .aboutMe:
                AboutMeView(selectedTab: $selectedTab, user: $user)
            default:
                Text("Error")
                    .font(.title)
            }
            
            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab, tabItems: managerTabItems, titleSize: 14)
            
        }
    }
}

#Preview {
    ManagerHomeView(selectedTab: .constant(.managerBookingList), user: .constant(nil), serviceStation: .constant(nil), selectedBooking: .constant(nil))
}
