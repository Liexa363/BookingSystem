//
//  AdministratorHome.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 26.04.2024.
//

import SwiftUI

struct AdministratorHomeView: View {
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>) {
        self._selectedTab = selectedTab
        self._user = user
    }
    
    let administratorTabItems = [
        TabItem(icon: "person.2.crop.square.stack", title: "Користувачі", tab: .userList),
        TabItem(icon: "car.2", title: "Автомобілі", tab: .carList),
        TabItem(icon: "wrench.adjustable", title: "Сервіси", tab: .serviceStationsList),
        TabItem(icon: "person", title: "Профіль", tab: .aboutMe)
    ]
    
    var body: some View {
        VStack {
            
            switch selectedTab {
            case .userList:
                UserListView(selectedTab: $selectedTab, user: $user)
            case .carList:
                CarListView(selectedTab: $selectedTab, user: $user)
            case .serviceStationsList:
                ServiceStationListView(selectedTab: $selectedTab, user: $user)
            case .aboutMe:
                AboutMeView(selectedTab: $selectedTab, user: $user)
            default:
                Text("Error")
                    .font(.title)
            }
            
            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab, tabItems: administratorTabItems)
            
        }
    }
}

#Preview {
    AdministratorHomeView(selectedTab: .constant(.userList), user: .constant(nil))
}
