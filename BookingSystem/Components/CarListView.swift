//
//  CarListView.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 29.04.2024.
//

import SwiftUI

struct CarListView: View {
    
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>) {
        self._selectedTab = selectedTab
        self._user = user
    }
    
    @State private var cars: [Car] = Array()
    
    @EnvironmentObject var realmManager: RealmManager
    
    @State private var isDelete = false
    @State private var carForDelete = Car(id: "", brand: "", model: "", year: "", bodyType: "", fuel: "", engineCapacity: "", transmission: "", color: "", registrationNumber: "", ownerID: "")
    
    var body: some View {
        ZStack {
            
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Автомобілі")
                        .font(.title)
                }
                .padding(.horizontal)
                
                ZStack {
                    
                    Color.white
                    
                    VStack {
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible())]) {
                                ForEach(0..<cars.count, id: \.self) { index in
                                    CarRow(car: cars[index], isDelete: $isDelete, carForDelete: $carForDelete)
                                    
                                    Divider().padding(.horizontal)
                                }
                            }
                            .padding()
                        }
                        .onAppear {
                            
                            cars = realmManager.getCars()
                        }
                    }
                    
                    HStack {
                        
                    }
                    .hidden()
                    .alert(isPresented: $isDelete) {
                        Alert(
                            title: Text("Повідомлення"),
                            message: Text("Ви впевнені, що хочете видалити автомобіль?"),
                            primaryButton: .default(Text("Так")) {
                                if realmManager.deleteCar(byID: carForDelete.id) {
                                    cars = realmManager.getCars()
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

struct CarRow: View {
    let car: Car
    
    @State var imageName: String = ""
    
    @EnvironmentObject var realmManager: RealmManager
    
    @Binding private var isDelete: Bool
    @Binding private var carForDelete: Car
    
    init(car: Car, isDelete: Binding<Bool>, carForDelete: Binding<Car>) {
        self.car = car
        self._isDelete = isDelete
        self._carForDelete = carForDelete
    }
    
    @State var owner: User = User(id: "", name: "", surname: "", phone: "", photo: "", email: "", password: "", role: "", date: "")
    
    var body: some View {
        HStack {
            VStack {
                
                HStack {
                    
                    HStack {
                        Text(car.brand)
                            .font(.title3)
                        Text(" \(car.model)")
                            .font(.title3)
                    }
                    
                    Spacer()
                    
                    Text(car.registrationNumber)
                        .font(.title3)
                }
                
                HStack {
                    
                    HStack {
                        switch car.fuel {
                        case "Gasoline":
                            Text("Бензин")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        case "Diesel":
                            Text("Дизель")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        case "Gas":
                            Text("Газ")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        case "Gas/Gasoline":
                            Text("Газ/Бензин")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        case "Hybrid":
                            Text("Гібрид")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        case "Electro":
                            Text("Електро")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        default:
                            Text("Error")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        
                        Text(" \(car.engineCapacity)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    switch car.transmission {
                    case "Automatic":
                        Text("Автомат")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    case "Manual":
                        Text("Ручна/механіка")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    case "Tiptronic":
                        Text("Типтронік")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    case "Robot":
                        Text("Робот")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    case "Variator":
                        Text("Варіатор")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    default:
                        Text("Error")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                }
                
            }
            .onAppear {
                
                if let tempOwner = realmManager.getUser(byOwnerID: car.ownerID) {
                    owner = tempOwner
                }
                
            }
            .contextMenu {
                Text("Рік випуску: \(car.year)")
                    .font(.body)
                
                switch car.bodyType {
                case "Universal":
                    Text("Тип кузова: Універсал")
                        .font(.body)
                case "Sedan":
                    Text("Тип кузова: Седан")
                        .font(.body)
                case "Hatch-back":
                    Text("Тип кузова: Хетчбек")
                        .font(.body)
                case "Crossover":
                    Text("Тип кузова: Кросовер")
                        .font(.body)
                case "Coupe":
                    Text("Тип кузова: Купе")
                        .font(.body)
                case "Cabriolet":
                    Text("Тип кузова: Кабріолет")
                        .font(.body)
                default:
                    Text("Error")
                        .font(.body)
                }
                
                Text("Колір: \(car.color)")
                    .font(.body)
                
                Text("Власник: \(owner.name) \(owner.surname)")
                    .font(.body)
            }
            
            Button(action: {
                withAnimation {
                    
                    isDelete = true
                    carForDelete = car
                    
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
    CarListView(selectedTab: .constant(.carList), user: .constant(nil))
}
