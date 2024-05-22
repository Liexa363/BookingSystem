//
//  ClientServiceStationsView.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 22.05.2024.
//

import SwiftUI

struct ClientServiceStationsView: View {
    
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>) {
        self._selectedTab = selectedTab
        self._user = user
    }
    
    @State private var serviceStations: [ServiceStation] = Array()
    
    @EnvironmentObject var realmManager: RealmManager
    
    var body: some View {
        ZStack {
            
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Сервіси")
                        .font(.title)
                }
                .padding(.horizontal)
                
                Spacer()
                
                ZStack {
                    
                    Color.white
                    
                    VStack {
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible())]) {
                                ForEach(0..<serviceStations.count, id: \.self) { index in
                                    ClientServiceStationRow(serviceStation: serviceStations[index])
                                    
                                    Divider().padding(.horizontal)
                                }
                            }
                            .padding()
                        }
                        .onAppear {
                            
                            serviceStations = realmManager.getServiceStations()
                        }
                    }
                    
                }
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding(.vertical)
                .padding()
            }
            
        }
    }
}

struct ClientServiceStationRow: View {
    let serviceStation: ServiceStation
    
    @EnvironmentObject var realmManager: RealmManager
    
    init(serviceStation: ServiceStation) {
        self.serviceStation = serviceStation
    }
    
    @State var manager: User = User(id: "", name: "", surname: "", phone: "", photo: "", email: "", password: "", role: "", date: "")
    
    var body: some View {
        HStack {
            VStack {
                
                HStack {
                    
                    HStack {
                        Text(serviceStation.name)
                            .font(.title3)
                    }
                    
                    Spacer()
                }
                
                HStack {
                    
                    HStack {
                        Text("Адреса: \(serviceStation.location.country), \(serviceStation.location.city), вул. \(serviceStation.location.street), буд. \(serviceStation.location.houseNumber)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
                
            }
            .onAppear {
                
                if let tempManager = realmManager.getUser(byManagerID: serviceStation.managerID) {
                    manager = tempManager
                }
                
            }
            .contextMenu {
                Text("Менеджер: \(manager.phone)")
                    .font(.body)
            }
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    ClientServiceStationsView(selectedTab: .constant(.clientHome), user: .constant(nil))
}
