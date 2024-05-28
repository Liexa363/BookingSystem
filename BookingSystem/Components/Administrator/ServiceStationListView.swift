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
    @State private var feedbackList: [Feedback] = Array()
    
    @EnvironmentObject var realmManager: RealmManager
    
    @State private var isDelete = false
    @State private var serviceStationForDelete = ServiceStation(id: "", name: "", location: Location(country: "", city: "", street: "", houseNumber: ""), services: [Service(name: "", serviceDescription: "", price: "")], managerID: "", workSchedule: [WorkSchedule(day: "", startTime: "", endTime: "", interval: "")], feedbackList: [Feedback(id: "", rating: "", text: "", date: "", author: "", serviceStationID: "")], masters: [Masters(serviceStationID: "", masterEmail: "")])
    @State private var feedbackForDelete = Feedback(id: "", rating: "", text: "", date: "", author: "", serviceStationID: "")
    
    @State private var selectedItem: Int = 0
    
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
                
                HStack {
                    HStack(spacing: 0) {
                        MenuItem(title: "Сервіси", isSelected: selectedItem == 0) {
                            selectedItem = 0
                        }
                        
                        MenuItem(title: "Відгуки", isSelected: selectedItem == 1) {
                            selectedItem = 1
                        }
                    }
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                }
                .shadow(radius: 10)
                .padding(.horizontal)
                
                if selectedItem == 0 {
                    VStack {
                        ZStack {
                            
                            Color.white
                            
                            if !serviceStations.isEmpty {
                                
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
                                }
                            } else {
                                
                                Text("Сервісів немає")
                                    .font(.title3)
                                    .foregroundStyle(.secondary)
                                
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
                        .onAppear {
                            
                            serviceStations = realmManager.getServiceStations()
                        }
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .padding()
                    }
                } else {
                    
                    VStack {
                        ZStack {
                            
                            Color.white
                            
                            if !feedbackList.isEmpty {
                                
                                VStack {
                                    ScrollView {
                                        LazyVGrid(columns: [GridItem(.flexible())]) {
                                            ForEach(0..<feedbackList.count, id: \.self) { index in
                                                FeedbackRow(feedback: feedbackList[index], isDelete: $isDelete, feedbackForDelete: $feedbackForDelete)
                                                
                                                Divider().padding(.horizontal)
                                            }
                                        }
                                        .padding()
                                    }
                                }
                            } else {
                                
                                Text("Відгуків немає")
                                    .font(.title3)
                                    .foregroundStyle(.secondary)
                                
                            }
                            
                            HStack {
                                
                            }
                            .hidden()
                            .alert(isPresented: $isDelete) {
                                Alert(
                                    title: Text("Повідомлення"),
                                    message: Text("Ви впевнені, що хочете видалити відгук?"),
                                    primaryButton: .default(Text("Так")) {
                                        if realmManager.deleteFeedback(byID: feedbackForDelete.id) {
                                            feedbackList = realmManager.getFeedbackList()
                                        } else {
                                            
                                        }
                                    },
                                    secondaryButton: .cancel(Text("Ні"))
                                )
                            }
                        }
                        .onAppear {
                            
                            feedbackList = realmManager.getFeedbackList()
                        }
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .padding()
                    }
                    
                }
                
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

struct MenuItem: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity, maxHeight: 40)
                .foregroundColor(isSelected ? .white : .black)
                .background(isSelected ? Color.blue : Color.clear)
                .cornerRadius(10)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 10)
//                        .stroke(Color.gray, lineWidth: isSelected ? 0 : 1)
//                )
        }
        .frame(height: 40)
    }
}

struct FeedbackRow: View {
    let feedback: Feedback
    
    @EnvironmentObject var realmManager: RealmManager
    
    @Binding private var isDelete: Bool
    @Binding private var feedbackForDelete: Feedback
    
    init(feedback: Feedback, isDelete: Binding<Bool>, feedbackForDelete: Binding<Feedback>) {
        self.feedback = feedback
        self._isDelete = isDelete
        self._feedbackForDelete = feedbackForDelete
    }
    
    @State var serviceStation: ServiceStation = ServiceStation(id: "", name: "", location: Location(country: "", city: "", street: "", houseNumber: ""), services: [Service(name: "", serviceDescription: "", price: "")], managerID: "", workSchedule: [WorkSchedule(day: "", startTime: "", endTime: "", interval: "")], feedbackList: [Feedback(id: "", rating: "", text: "", date: "", author: "", serviceStationID: "")], masters: [Masters(serviceStationID: "", masterEmail: "")])
    
    var body: some View {
        HStack {
            VStack {
                
                HStack {
                    
                    VStack {
                        
                        HStack {
                            Text(serviceStation.name)
                                .font(.body)
                            
                            Spacer()
                            
                            HStack(spacing: 2) {
                                ForEach(0..<5) { index in
                                    StarView(filled: index < Int(feedback.rating) ?? 0)
                                }
                            }
                        }
                        
                        HStack {
                            Text(feedback.date)
                                .font(.body)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            Text(feedback.author)
                                .font(.body)
                                .foregroundColor(.secondary)
                        }
                        .padding(.bottom, 10)
                    }
                    
                    VStack {
                        
                        Button(action: {
                            withAnimation {
                                
                                isDelete = true
                                feedbackForDelete = feedback
                                
                            }
                            
                        }) {
                            Image(systemName: "trash")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
                                .shadow(radius: 10)
                                .padding(.leading)
                        }
                        .padding(.top, 10)
                        
                        Spacer()
                    }
                }
                
                HStack {
                    Text(feedback.text)
                        .font(.body)
                    
                    Spacer()
                }
                
            }
            .onAppear {
                
                serviceStation = realmManager.getServiceStation(byID: feedback.serviceStationID)
                
            }
            .contextMenu {
//                Text("Менеджер: \(manager.phone)")
//                    .font(.body)
            }
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    ServiceStationListView(selectedTab: .constant(.serviceStationsList), user: .constant(nil))
}
