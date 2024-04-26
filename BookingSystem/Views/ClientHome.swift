//
//  ClientHome.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 26.04.2024.
//

import SwiftUI

struct ClientHome: View {
    
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
        TabItem(icon: "info.circle", title: "Про мене", tab: .aboutMe)
    ]
    
    var body: some View {
        VStack {
            switch selectedTab {
            case .clientHome:
                Text("ClientHome")
                    .font(.title)
                    .foregroundStyle(.black)
            case .clientFavorites:
                Text("ClientFavorites")
                    .font(.title)
            case .clientBookingList:
                Text("ClientBookingList")
                    .font(.title)
            case .aboutMe:
                Text("ClientAboutMe")
                    .font(.title)
            default:
                Text("Error")
                    .font(.title)
            }
            
            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab, tabItems: clientTabItems)
            
        }
        .onAppear {
            print("selectedTab: \(selectedTab)")
            print("user: \(user)")
            print("role: \(user!.role)")
        }
        .onTapGesture {
            print("tapped")
        }
    }
}

#Preview {
    ClientHome(selectedTab: .constant(.clientHome), user: .constant(nil))
}
