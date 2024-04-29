//
//  ClientCarView.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 28.04.2024.
//

import SwiftUI

struct ClientCarView: View {
    
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    @Binding private var car: Car?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>, car: Binding<Car?>) {
        self._selectedTab = selectedTab
        self._user = user
        self._car = car
    }
    
    @EnvironmentObject var realmManager: RealmManager
    
    @State private var isCarDataLoaded = false
    
    var body: some View {
        ZStack {
            
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("fff")
                        .foregroundStyle(Color("backgroundColor"))
                    
                    Spacer()
                    
                    Text("Автомобіль")
                        .font(.title)
                    
                    Spacer()
                    
                    
                    if realmManager.isCarExist(forUserID: user!.id) {
                        Button(action: {
                            
                            selectedTab = .editCar
                            
                        }) {
                            Image(systemName: "pencil")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
                                .shadow(radius: 10)
                        }
                    } else {
                        Button(action: {
                            
                            selectedTab = .addCar
                            
                        }) {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
                                .shadow(radius: 10)
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                ZStack {
                    
                    Color.white
                    
                    VStack {
                        if realmManager.isCarExist(forUserID: user!.id) {
                            
                            if isCarDataLoaded {
                                
                                VStack {
                                    HStack {
                                        Text("Марка")
                                            .font(.body)
                                            .foregroundStyle(.secondary)
                                        
                                        Spacer()
                                        
                                        Text(car!.brand)
                                            .font(.body)
                                    }
                                    
                                    Divider().padding(.vertical, 10)
                                    
                                    HStack {
                                        Text("Модель")
                                            .font(.body)
                                            .foregroundStyle(.secondary)
                                        
                                        Spacer()
                                        
                                        Text(car!.model)
                                            .font(.body)
                                    }
                                    
                                    Divider().padding(.vertical, 10)
                                    
                                    HStack {
                                        Text("Рік випуску")
                                            .font(.body)
                                            .foregroundStyle(.secondary)
                                        
                                        Spacer()
                                        
                                        Text(car!.year)
                                            .font(.body)
                                    }
                                    
                                    Divider().padding(.vertical, 10)
                                    
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
                                    
                                    Divider().padding(.vertical, 10)
                                    
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
                                    
                                    Divider().padding(.vertical, 10)
                                    
                                    HStack {
                                        Text("Обʼєм мотору")
                                            .font(.body)
                                            .foregroundStyle(.secondary)
                                        
                                        Spacer()
                                        
                                        Text(car!.engineCapacity)
                                            .font(.body)
                                    }
                                    
                                    Divider().padding(.vertical, 10)
                                    
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
                                    
                                    Divider().padding(.vertical, 10)
                                    
                                    HStack {
                                        Text("Колір")
                                            .font(.body)
                                            .foregroundStyle(.secondary)
                                        
                                        Spacer()
                                        
                                        Text(car!.color)
                                            .font(.body)
                                    }
                                    
                                    Divider().padding(.vertical, 10)
                                    
                                    HStack {
                                        Text("Реєстраційний номер")
                                            .font(.body)
                                            .foregroundStyle(.secondary)
                                        
                                        Spacer()
                                        
                                        Text(car!.registrationNumber)
                                            .font(.body)
                                    }
                                    
                                }
                                .padding(.all, 30)
                                
                            } else {
                                
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle())
                                    .padding()
                                
                            }
                            
                        } else {
                            Text("Автомобіль не доданий")
                                .font(.title3)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .onAppear {
                    
                    isCarDataLoaded = false
                    
                    DispatchQueue.main.async {
                        
                        if let tempCar = realmManager.getCar(byOwnerID: user!.id) {
                            
                            car = tempCar
                            
                            isCarDataLoaded = true
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

#Preview {
    ClientCarView(selectedTab: .constant(.clientCar), user: .constant(nil), car: .constant(nil))
}
