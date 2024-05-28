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
    @Binding private var serviceStation: ServiceStation?
    @Binding private var selectedBooking: Booking?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>, serviceStation: Binding<ServiceStation?>, selectedBooking: Binding<Booking?>) {
        self._selectedTab = selectedTab
        self._user = user
        self._serviceStation = serviceStation
        self._selectedBooking = selectedBooking
    }
    
    let masterTabItems = [
        TabItem(icon: "clock", title: "Бронювання", tab: .masterBookingList),
        TabItem(icon: "wrench.adjustable", title: "Сервіс", tab: .masterServiceStation),
        TabItem(icon: "person", title: "Профіль", tab: .aboutMe)
    ]
    
    var body: some View {
        VStack {
            
            switch selectedTab {
            case .masterBookingList:
                MasterBookingListView(selectedTab: $selectedTab, user: $user, serviceStation: $serviceStation, selectedBooking: $selectedBooking)
            case .masterServiceStation:
                MasterServiceStationView(selectedTab: $selectedTab, user: $user, serviceStation: $serviceStation)
            case .aboutMe:
                AboutMeView(selectedTab: $selectedTab, user: $user)
            default:
                Text("Error")
                    .font(.title)
            }
            
            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab, tabItems: masterTabItems, titleSize: 14)
            
        }
    }
}

#Preview {
    MasterHomeView(selectedTab: .constant(.masterBookingList), user: .constant(nil), serviceStation: .constant(nil), selectedBooking: .constant(nil))
}
