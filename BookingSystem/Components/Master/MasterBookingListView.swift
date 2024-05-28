//
//  MasterBookingList.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 28.05.2024.
//

import SwiftUI

struct MasterBookingListView: View {
    
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
    
    @State private var bookingList: [Booking] = Array()
    
    @EnvironmentObject var realmManager: RealmManager
    
    var body: some View {
        ZStack {
            
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Бронювання")
                        .font(.title)
                }
                .padding(.horizontal)
                
                ZStack {
                    
                    Color.white
                    
                    if !bookingList.isEmpty {
                        
                        VStack {
                            ScrollView {
                                LazyVGrid(columns: [GridItem(.flexible())]) {
                                    ForEach(0..<bookingList.count, id: \.self) { index in
                                        
                                        Button(action: {
                                            
                                            selectedBooking = bookingList[index]
                                            selectedTab = .masterAboutBooking
                                            
                                        }) {
                                            
                                            MasterBookingListRow(booking: bookingList[index], refreshBookingList: refreshBookingList)
                                            
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        
                                        Divider().padding(.horizontal)
                                    }
                                }
                                .padding()
                            }
                            
                        }
                    } else {
                        
                        Text("Бронювань немає")
                            .font(.title3)
                            .foregroundStyle(.secondary)
                        
                    }
                    
                }
                .onAppear {
                    
                    if let serviceStationID = realmManager.getServiceStationID(byMasterEmail: user!.email) {
                        
                        serviceStation = realmManager.getServiceStation(byID: serviceStationID)
                        
                    }
                    
                    refreshBookingList()
                }
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding(.horizontal)
                .padding(.bottom)
                .padding(.top, 5)
            }
            
        }
    }
    
    private func refreshBookingList() {
        if let serviceStation = serviceStation {
            bookingList = realmManager.getBookingList(byServiceStationID: serviceStation.id)
        }
    }
}

struct MasterBookingListRow: View {
    let booking: Booking
    
    @EnvironmentObject var realmManager: RealmManager
    
    var refreshBookingList: () -> Void
    
    init(booking: Booking, refreshBookingList: @escaping () -> Void) {
        self.booking = booking
        self.refreshBookingList = refreshBookingList
    }
    
    @State var car: Car = Car(id: "", brand: "", model: "", year: "", bodyType: "", fuel: "", engineCapacity: "", transmission: "", color: "", registrationNumber: "", ownerID: "")
    
    var body: some View {
        HStack {
            VStack {
                
                HStack {
                    
                    HStack {
                        Text(booking.date)
                            .font(.title3)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text(booking.time)
                            .font(.title3)
                    }
                }
                
                HStack {
                    
                    HStack {
                        Text("\(car.brand) \(car.model)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text("\(booking.client.surname) \(booking.client.name)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
            }
            .onAppear {
                
                if let tempCar = realmManager.getCar(byOwnerID: booking.client.id) {
                    car = tempCar
                } else {
                    car = Car(id: "", brand: "", model: "", year: "", bodyType: "", fuel: "", engineCapacity: "", transmission: "", color: "", registrationNumber: "", ownerID: "")
                }
                
            }
            
        }
        .padding(.horizontal)
    }
}

#Preview {
    MasterBookingListView(selectedTab: .constant(.masterBookingList), user: .constant(nil), serviceStation: .constant(nil), selectedBooking: .constant(nil))
}
