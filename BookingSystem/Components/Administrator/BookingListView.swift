//
//  AdministratorBookingListView.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 25.05.2024.
//

import SwiftUI

struct BookingListView: View {
    
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>) {
        self._selectedTab = selectedTab
        self._user = user
    }
    
    @State private var bookingList: [Booking] = Array()
    
    @EnvironmentObject var realmManager: RealmManager
    
    @State private var isDelete = false
    @State private var bookingForDelete = Booking(id: "", date: "", time: "", serviceStation: ServiceStation(id: "", name: "", location: Location(country: "", city: "", street: "", houseNumber: ""), services: [Service(name: "", serviceDescription: "", price: "")], managerID: "", workSchedule: [WorkSchedule(day: "", startTime: "", endTime: "", interval: "")], feedbackList: [Feedback(id: "", rating: "", text: "", date: "", author: "", serviceStationID: "")], masters: [Masters(serviceStationID: "", masterEmail: "")]), client: User(id: "", name: "", surname: "", phone: "", photo: "", email: "", password: "", role: "", date: ""), service: Service(name: "", serviceDescription: "", price: ""))
    
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
                                        BookingListRow(booking: bookingList[index], isDelete: $isDelete, bookingForDelete: $bookingForDelete, refreshBookingList: refreshBookingList)
                                        
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
                    
                    HStack {
                        
                    }
                    .hidden()
                    .alert(isPresented: $isDelete) {
                        Alert(
                            title: Text("Повідомлення"),
                            message: Text("Ви впевнені, що хочете видалити запис?"),
                            primaryButton: .default(Text("Так")) {
                                if realmManager.deleteBooking(byID: bookingForDelete.id) {
                                    
                                    refreshBookingList()
                                    
                                } else {
                                    
                                }
                            },
                            secondaryButton: .cancel(Text("Ні"))
                        )
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
        bookingList = realmManager.getBookingList()
    }
}

struct BookingListRow: View {
    let booking: Booking
    
    @State var imageName: String = ""
    
    @EnvironmentObject var realmManager: RealmManager
    
    @Binding private var isDelete: Bool
    @Binding private var bookingForDelete: Booking
    
    var refreshBookingList: () -> Void
    
    init(booking: Booking, isDelete: Binding<Bool>, bookingForDelete: Binding<Booking>, refreshBookingList: @escaping () -> Void) {
        self.booking = booking
        self._isDelete = isDelete
        self._bookingForDelete = bookingForDelete
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
                        Text("\(booking.serviceStation.name)")
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
            .contextMenu {
                Text("Клієнт: \(booking.client.surname) \(booking.client.name)")
                    .font(.body)
            }
            
            Button(action: {
                withAnimation {
                    
                    isDelete = true
                    bookingForDelete = booking
                    
                    refreshBookingList()
                    
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
    BookingListView(selectedTab: .constant(.administratorBookingList), user: .constant(nil))
}
