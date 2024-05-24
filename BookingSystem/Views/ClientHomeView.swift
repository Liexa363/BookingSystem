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
    @Binding private var car: Car?
    @Binding private var selectedServiceStation: ServiceStation?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>, car: Binding<Car?>, selectedServiceStation: Binding<ServiceStation?>) {
        self._selectedTab = selectedTab
        self._user = user
        self._car = car
        self._selectedServiceStation = selectedServiceStation
    }
    
    let clientTabItems = [
        TabItem(icon: "house", title: "Домашня", tab: .clientHome),
        TabItem(icon: "car.side", title: "Автомобіль", tab: .clientCar),
        TabItem(icon: "clock", title: "Бронювання", tab: .clientBookingList),
        TabItem(icon: "person", title: "Профіль", tab: .aboutMe)
    ]
    
    var body: some View {
        VStack {
            
            switch selectedTab {
            case .clientHome:
                ClientServiceStationsView(selectedTab: $selectedTab, user: $user, selectedServiceStation: $selectedServiceStation)
            case .clientCar:
                ClientCarView(selectedTab: $selectedTab, user: $user, car: $car)
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
    ClientHomeView(selectedTab: .constant(.clientHome), user: .constant(nil), car: .constant(nil), selectedServiceStation: .constant(nil))
}
