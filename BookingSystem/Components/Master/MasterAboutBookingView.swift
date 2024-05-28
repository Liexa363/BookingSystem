//
//  MasterAboutBookingView.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 28.05.2024.
//

import SwiftUI

struct MasterAboutBookingView: View {
    
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    @Binding private var selectedBooking: Booking?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>, selectedBooking: Binding<Booking?>) {
        self._selectedTab = selectedTab
        self._user = user
        self._selectedBooking = selectedBooking
    }
    
    @State private var car: Car? = nil
    
    @EnvironmentObject var realmManager: RealmManager
    
    var body: some View {
        ZStack {
            
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    
                    Button(action: {
                        withAnimation {
                            selectedTab = .masterBookingList
                        }
                    }) {
                        Text("< Назад")
                            .foregroundStyle(.black)
                            .font(.title3)
                    }
                    
                    Spacer()
                    
                }
                .onAppear {
                    if let tempCar = realmManager.getCar(byOwnerID: selectedBooking!.client.id) {
                        car = tempCar
                    }
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
                                    Text("Послуга")
                                        .font(.body)
                                        .foregroundStyle(.secondary)
                                    
                                    Spacer()
                                }
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text(selectedBooking!.service.name)
                                        .font(.body)
                                    
                                    Spacer()
                                }
                            }
                            
                            Divider().padding(.vertical, 10)
                            
                            if car != nil {
                                
                                VStack {
                                    HStack {
                                        Text("Автомобіль:")
                                            .font(.body)
                                        
                                        Spacer()
                                    }
                                    .padding(.bottom, 10)
                                    
                                    HStack {
                                        Text("Марка")
                                            .font(.body)
                                            .foregroundStyle(.secondary)
                                        
                                        Spacer()
                                        
                                        Text(car!.brand)
                                            .font(.body)
                                    }
                                    
                                    Divider()
                                        .padding(.vertical, 1)
                                        .padding(.horizontal, 20)
                                    
                                    HStack {
                                        Text("Модель")
                                            .font(.body)
                                            .foregroundStyle(.secondary)
                                        
                                        Spacer()
                                        
                                        Text(car!.model)
                                            .font(.body)
                                    }
                                    
                                    Divider()
                                        .padding(.vertical, 1)
                                        .padding(.horizontal, 20)
                                    
                                    HStack {
                                        Text("Рік випуску")
                                            .font(.body)
                                            .foregroundStyle(.secondary)
                                        
                                        Spacer()
                                        
                                        Text(car!.year)
                                            .font(.body)
                                    }
                                    
                                    Divider()
                                        .padding(.vertical, 1)
                                        .padding(.horizontal, 20)
                                    
                                    HStack {
                                        
                                        Text("Тип кузова")
                                            .font(.body)
                                            .foregroundStyle(.secondary)
                                        
                                        Spacer()
                                        
                                        switch car!.bodyType {
                                        case "Universal":
                                            Text("Універсал")
                                                .font(.body)
                                        case "Sedan":
                                            Text("Седан")
                                                .font(.body)
                                        case "Hatch-back":
                                            Text("Хетчбек")
                                                .font(.body)
                                        case "Crossover":
                                            Text("Кросовер")
                                                .font(.body)
                                        case "Coupe":
                                            Text("Купе")
                                                .font(.body)
                                        case "Cabriolet":
                                            Text("Кабріолет")
                                                .font(.body)
                                        default:
                                            Text("Error")
                                                .font(.body)
                                        }
                                    }
                                    
                                    Divider()
                                        .padding(.vertical, 1)
                                        .padding(.horizontal, 20)
                                    
                                    HStack {
                                        Text("Паливо")
                                            .font(.body)
                                            .foregroundStyle(.secondary)
                                        
                                        Spacer()
                                        
                                        switch car!.fuel {
                                        case "Gasoline":
                                            Text("Бензин")
                                                .font(.body)
                                        case "Diesel":
                                            Text("Дизель")
                                                .font(.body)
                                        case "Gas":
                                            Text("Газ")
                                                .font(.body)
                                        case "Gas/Gasoline":
                                            Text("Газ/Бензин")
                                                .font(.body)
                                        case "Hybrid":
                                            Text("Гібрид")
                                                .font(.body)
                                        case "Electro":
                                            Text("Електро")
                                                .font(.body)
                                        default:
                                            Text("Error")
                                                .font(.body)
                                        }
                                    }
                                    
                                    Divider()
                                        .padding(.vertical, 1)
                                        .padding(.horizontal, 20)
                                    
                                    HStack {
                                        Text("Обʼєм мотору")
                                            .font(.body)
                                            .foregroundStyle(.secondary)
                                        
                                        Spacer()
                                        
                                        Text(car!.engineCapacity)
                                            .font(.body)
                                    }
                                    
                                    Divider()
                                        .padding(.vertical, 1)
                                        .padding(.horizontal, 20)
                                    
                                    HStack {
                                        Text("КПП")
                                            .font(.body)
                                            .foregroundStyle(.secondary)
                                        
                                        Spacer()
                                        
                                        switch car!.transmission {
                                        case "Automatic":
                                            Text("Автомат")
                                                .font(.body)
                                        case "Manual":
                                            Text("Ручна/механіка")
                                                .font(.body)
                                        case "Tiptronic":
                                            Text("Типтронік")
                                                .font(.body)
                                        case "Robot":
                                            Text("Робот")
                                                .font(.body)
                                        case "Variator":
                                            Text("Варіатор")
                                                .font(.body)
                                        default:
                                            Text("Error")
                                                .font(.body)
                                        }
                                    }
                                    
                                    Divider()
                                        .padding(.vertical, 1)
                                        .padding(.horizontal, 20)
                                    
                                    HStack {
                                        Text("Колір")
                                            .font(.body)
                                            .foregroundStyle(.secondary)
                                        
                                        Spacer()
                                        
                                        Text(car!.color)
                                            .font(.body)
                                    }
                                    
                                    Divider()
                                        .padding(.vertical, 1)
                                        .padding(.horizontal, 20)
                                    
                                    HStack {
                                        Text("Реєстраційний номер")
                                            .font(.body)
                                            .foregroundStyle(.secondary)
                                        
                                        Spacer()
                                        
                                        Text(car!.registrationNumber)
                                            .font(.body)
                                    }
                                    
                                }
                                
                            }
                            
                            Divider().padding(.vertical, 10)
                            
                            VStack {
                                HStack {
                                    Text("Клієнт:")
                                        .font(.body)
                                    
                                    Spacer()
                                }
                                .padding(.bottom, 10)
                                
                                HStack {
                                    Text("Імʼя")
                                        .font(.body)
                                        .foregroundStyle(.secondary)
                                    
                                    Spacer()
                                    
                                    Text(selectedBooking!.client.name)
                                        .font(.body)
                                }
                                
                                Divider()
                                    .padding(.vertical, 1)
                                    .padding(.horizontal, 20)
                                
                                HStack {
                                    Text("Прізвище")
                                        .font(.body)
                                        .foregroundStyle(.secondary)
                                    
                                    Spacer()
                                    
                                    Text(selectedBooking!.client.surname)
                                        .font(.body)
                                }
                                
                                Divider()
                                    .padding(.vertical, 1)
                                    .padding(.horizontal, 20)
                                
                                HStack {
                                    Text("Номер телефону")
                                        .font(.body)
                                        .foregroundStyle(.secondary)
                                    
                                    Spacer()
                                    
                                    Link(destination: URL(string: "tel:\(selectedBooking!.client.phone)")!) {
                                        Text(selectedBooking!.client.phone)
                                            .font(.body)
                                    }
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
    MasterAboutBookingView(selectedTab: .constant(.masterAboutBooking), user: .constant(nil), selectedBooking: .constant(nil))
}
