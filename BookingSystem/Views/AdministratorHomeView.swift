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
        TabItem(icon: "person.2.crop.square.stack", title: "Користувачі", tab: .usersList),
        TabItem(icon: "exclamationmark.triangle", title: "Скарги", tab: .complaintsList),
        TabItem(icon: "wrench.adjustable", title: "Сервіси", tab: .serviceStationsList),
        TabItem(icon: "person", title: "Профіль", tab: .aboutMe)
    ]
    
    var body: some View {
        VStack {
            
            switch selectedTab {
            case .usersList:
                Text("AdministratorHome")
                    .font(.title)
            case .complaintsList:
                Text("ComplaintsList")
                    .font(.title)
            case .serviceStationsList:
                Text("ServiceStationsList")
                    .font(.title)
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
    AdministratorHomeView(selectedTab: .constant(.usersList), user: .constant(nil))
}
