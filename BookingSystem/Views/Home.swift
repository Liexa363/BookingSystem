//
//  Home.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 25.04.2024.
//

import SwiftUI

struct Home: View {
    
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>) {
        self._selectedTab = selectedTab
        self._user = user
    }
    
    @EnvironmentObject var realmManager: RealmManager
    
    var body: some View {
        VStack {
            
            switch user!.role {
            case "Client":
//                ClientHome(selectedTab: $selectedTab, user: $user)
                Text("Client")
                    .font(.title)
            case "Manager":
                ManagerHome(selectedTab: $selectedTab, user: $user)
            case "Master":
                MasterHome(selectedTab: $selectedTab, user: $user)
            case "Administrator":
                AdministratorHome(selectedTab: $selectedTab, user: $user)
            default:
                Text("Some error")
            }
            
            
//            кнопка вийти
//            Button(action: {
//                withAnimation {
//                    realmManager.logout()
//                    
//                    selectedTab = .suggestSignInUp
//                }
//            }) {
//                Text("Вийти")
//                    .foregroundColor(.black)
//                    .font(.title2)
//            }
//            .frame(width: 200, height: 50)
//            .background(.ultraThinMaterial)
//            .cornerRadius(10)
//            .shadow(radius: 10)
//            .padding(.bottom, 50)
            
        }
        .onAppear {
            switch user!.role {
            case "Client":
                selectedTab = .clientHome
            case "Manager":
                selectedTab = .managerHome
            case "Master":
                selectedTab = .masterHome
            case "Administrator":
                selectedTab = .administratorHome
            default:
                selectedTab = .home
            }
        }
        
        
    }
}

#Preview {
    Home(selectedTab: .constant(.clientHome), user: .constant(nil))
}
