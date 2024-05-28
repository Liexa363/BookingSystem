//
//  ClientAboutBookingView.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 26.05.2024.
//

import SwiftUI

struct ClientAboutBookingView: View {
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    @Binding private var selectedBooking: Booking?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>, selectedBooking: Binding<Booking?>) {
        self._selectedTab = selectedTab
        self._user = user
        self._selectedBooking = selectedBooking
    }
    
    @EnvironmentObject var realmManager: RealmManager
    
    var body: some View {
        ZStack {
            
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    
                    Button(action: {
                        withAnimation {
                            selectedTab = .clientBookingList
                        }
                    }) {
                        Text("< Назад")
                            .foregroundStyle(.black)
                            .font(.title3)
                    }
                    
                    Spacer()
                    
                }
                .padding(.horizontal)
                
                Spacer()
                
                ZStack {
                    
                    Color.white
                    
                    ScrollView {
                        
                        VStack {
                            
                            HStack {
                                Text("Дата")
                                    .font(.body)
                                    .foregroundStyle(.secondary)
                                
                                Spacer()
                                
                                Text(selectedBooking!.date)
                                    .font(.body)
                            }
                            
                            Divider().padding(.vertical, 10)
                            
                            HStack {
                                Text("Час")
                                    .font(.body)
                                    .foregroundStyle(.secondary)
                                
                                Spacer()
                                
                                Text(selectedBooking!.time)
                                    .font(.body)
                            }
                            
                            Divider().padding(.vertical, 10)
                            
                            VStack {
                                HStack {
                                    Text("Послуга:")
                                        .font(.body)
                                    
                                    Spacer()
                                }
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text(selectedBooking!.service.name)
                                        .font(.body)
                                    
                                    Spacer()
                                }
                                
                                Divider()
                                    .padding(.vertical, 1)
                                    .padding(.horizontal, 20)
                                
                                HStack {
                                    Text("Опис")
                                        .font(.body)
                                        .foregroundStyle(.secondary)
                                    
                                    Spacer()
                                }
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text(selectedBooking!.service.serviceDescription)
                                        .font(.body)
                                    
                                    Spacer()
                                }
                                
                                Divider()
                                    .padding(.vertical, 1)
                                    .padding(.horizontal, 20)
                                
                                HStack {
                                    Text("Ціна")
                                        .font(.body)
                                        .foregroundStyle(.secondary)
                                    
                                    Spacer()
                                }
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text(selectedBooking!.service.price)
                                        .font(.body)
                                    
                                    Spacer()
                                }
                            }
                            
                            Divider().padding(.vertical, 10)
                            
                            VStack {
                                HStack {
                                    Text("Сервіс:")
                                        .font(.body)
                                    
                                    Spacer()
                                }
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text(selectedBooking!.serviceStation.name)
                                        .font(.body)
                                    
                                    Spacer()
                                }
                                
                                Divider()
                                    .padding(.vertical, 1)
                                    .padding(.horizontal, 20)
                                
                                HStack {
                                    Text("Адреса")
                                        .font(.body)
                                        .foregroundStyle(.secondary)
                                    
                                    Spacer()
                                }
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("\(selectedBooking!.serviceStation.location.country), \(selectedBooking!.serviceStation.location.city), вул. \(selectedBooking!.serviceStation.location.street), буд. \(selectedBooking!.serviceStation.location.houseNumber)")
                                        .font(.body)
                                    
                                    Spacer()
                                }
                                
                            }
                            
                            
                        }
                        .padding(.all, 30)
                        
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

#Preview {
    ClientAboutBookingView(selectedTab: .constant(.clientAboutBooking), user: .constant(nil), selectedBooking: .constant(nil))
}
