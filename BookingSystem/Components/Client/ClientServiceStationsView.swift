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
    @Binding private var selectedServiceStation: ServiceStation?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>, selectedServiceStation: Binding<ServiceStation?>) {
        self._selectedTab = selectedTab
        self._user = user
        self._selectedServiceStation = selectedServiceStation
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
                    
                    if !serviceStations.isEmpty {
                        
                        VStack {
                            ScrollView {
                                LazyVGrid(columns: [GridItem(.flexible())]) {
                                    ForEach(0..<serviceStations.count, id: \.self) { index in
                                        
                                        Button(action: {
                                            
                                            selectedServiceStation = serviceStations[index]
                                            selectedTab = .clientAboutServiceStation
                                            
                                        }) {
                                            ClientServiceStationRow(serviceStation: serviceStations[index])
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        
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
                    
                }
                .onAppear {
                    
                    serviceStations = realmManager.getServiceStations()
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
    
    @State var averageRating = 0
    
    var body: some View {
        HStack {
            VStack {
                
                HStack {
                    
                    HStack {
                        Text(serviceStation.name)
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 2) {
                        ForEach(0..<5) { index in
                            StarView(filled: index < averageRating)
                        }
                    }
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
                
                averageRating = Int(StarView().averageRating(from: serviceStation.feedbackList) ?? 0)
                
            }
            .contextMenu {
                Text("Менеджер: \(manager.phone)")
                    .font(.body)
            }
            
        }
        .padding(.horizontal)
    }
}

struct StarView: View {
    var filled: Bool = false

    var body: some View {
        Image(systemName: filled ? "star.fill" : "star")
            .foregroundColor(filled ? .yellow : .gray)
    }
    
    func averageRating(from feedbackList: [Feedback]) -> Double? {
        // Filter out feedback entries with non-numeric ratings and convert to Double
        let numericRatings = feedbackList.compactMap { feedback -> Double? in
            return Double(feedback.rating)
        }
        
        // Check if there are any numeric ratings
        guard !numericRatings.isEmpty else {
            return nil // or return 0.0 if you prefer
        }
        
        // Calculate the sum of the numeric ratings
        let sum = numericRatings.reduce(0, +)
        
        // Calculate the arithmetic mean
        let mean = sum / Double(numericRatings.count)
        
        return mean
    }

}

#Preview {
    ClientServiceStationsView(selectedTab: .constant(.clientHome), user: .constant(nil), selectedServiceStation: .constant(nil))
}
