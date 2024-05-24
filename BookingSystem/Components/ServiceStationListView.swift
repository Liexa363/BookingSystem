//
//  ServiceStationListView.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 22.05.2024.
//

import SwiftUI

struct ServiceStationListView: View {
    
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>) {
        self._selectedTab = selectedTab
        self._user = user
    }
    
    @State private var serviceStations: [ServiceStation] = Array()
    
    @EnvironmentObject var realmManager: RealmManager
    
    @State private var isDelete = false
    @State private var serviceStationForDelete = ServiceStation(id: "", name: "", location: Location(country: "", city: "", street: "", houseNumber: ""), services: [Service(name: "", serviceDescription: "", price: "")], managerID: "", workSchedule: [WorkSchedule(day: "", startTime: "", endTime: "", interval: "")])
    
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
                
                ZStack {
                    
                    Color.white
                    
                    VStack {
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible())]) {
                                ForEach(0..<serviceStations.count, id: \.self) { index in
                                    ServiceStationRow(serviceStation: serviceStations[index], isDelete: $isDelete, serviceStationForDelete: $serviceStationForDelete)
                                    
                                    Divider().padding(.horizontal)
                                }
                            }
                            .padding()
                        }
                        .onAppear {
                            
                            serviceStations = realmManager.getServiceStations()
                        }
                    }
                    
                    HStack {
                        
                    }
                    .hidden()
                    .alert(isPresented: $isDelete) {
                        Alert(
                            title: Text("Повідомлення"),
                            message: Text("Ви впевнені, що хочете видалити сервіс?"),
                            primaryButton: .default(Text("Так")) {
                                if realmManager.deleteServiceStation(byID: serviceStationForDelete.id) {
                                    serviceStations = realmManager.getServiceStations()
                                } else {
                                    
                                }
                            },
                            secondaryButton: .cancel(Text("Ні"))
                        )
                    }
                }
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding(.horizontal)
                .padding(.bottom)
                .padding(.top, 5)
            }
            
        }
    }
}

struct ServiceStationRow: View {
    let serviceStation: ServiceStation
    
    @State var imageName: String = ""
    
    @EnvironmentObject var realmManager: RealmManager
    
    @Binding private var isDelete: Bool
    @Binding private var serviceStationForDelete: ServiceStation
    
    init(serviceStation: ServiceStation, isDelete: Binding<Bool>, serviceStationForDelete: Binding<ServiceStation>) {
        self.serviceStation = serviceStation
        self._isDelete = isDelete
        self._serviceStationForDelete = serviceStationForDelete
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
            
            Button(action: {
                withAnimation {
                    
                    isDelete = true
                    serviceStationForDelete = serviceStation
                    
                }
                
            }) {
                Image(systemName: "trash")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
                    .shadow(radius: 10)
                    .padding(.leading)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    ServiceStationListView(selectedTab: .constant(.serviceStationsList), user: .constant(nil))
}
