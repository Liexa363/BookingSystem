//
//  ClientBookingListView.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 26.05.2024.
//

import SwiftUI

struct ClientBookingListView: View {
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    @Binding private var selectedBooking: Booking?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>, selectedBooking: Binding<Booking?>) {
        self._selectedTab = selectedTab
        self._user = user
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
                                            selectedTab = .clientAboutBooking
                                            
                                        }) {
                                            
                                            ClientBookingListRow(booking: bookingList[index], refreshBookingList: refreshBookingList)
                                            
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
        bookingList = realmManager.getBookingList(byClientID: user!.id)
    }
}

struct ClientBookingListRow: View {
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
                        Text("\(booking.serviceStation.name)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text("\(booking.service.name)")
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
    ClientBookingListView(selectedTab: .constant(.clientBookingList), user: .constant(nil), selectedBooking: .constant(nil))
}
