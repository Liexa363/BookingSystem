//
//  AddCarView.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 29.04.2024.
//

import SwiftUI

struct AddCarView: View {
    
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    @Binding private var car: Car?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>, car: Binding<Car?>) {
        self._selectedTab = selectedTab
        self._user = user
        self._car = car
    }
    
    @State private var brand: String = ""
    @State private var model: String = ""
    @State private var year: String = ""
    @State private var bodyType: String = "Universal"
    @State private var fuel: String = "Gasoline"
    @State private var engineCapacity: String = ""
    @State private var transmission: String = "Automatic"
    @State private var color: String = ""
    @State private var registrationNumber: String = ""
    @State private var ownerID: String = ""
    
    @State private var empty: String = ""
    
    @State private var isSomeFieldIsEmpty = false
    @State private var isSuccessfulAdding = false
    @State private var isAddingError = false
    
    @EnvironmentObject var realmManager: RealmManager
    
    var body: some View {
        ZStack {
            
            Color("backgroundColor")
                .ignoresSafeArea()
            
            ScrollView {
                HStack {
                    Button(action: {
                        withAnimation {
                            selectedTab = .clientCar
                        }
                    }) {
                        Text("< Назад")
                            .foregroundStyle(.black)
                            .font(.title3)
                    }
                    
                    Spacer()
                }
                .alert(isPresented: $isSomeFieldIsEmpty) {
                    Alert(title: Text("Помилка"),
                          message: Text("Якесь поле не заповнено. Перевірте, будь ласка, та заповніть всі поля."),
                          dismissButton: .default(Text("OK")))
                }
                .padding()
                
                Spacer()
                
                ZStack {
                    Color.white
                    
                    VStack {
                        
                        HStack {
                            Text("Додавання")
                                .font(.title)
                            
                            Spacer()
                        }
                        .alert(isPresented: $isSuccessfulAdding) {
                            Alert(title: Text("Повідомлення"),
                                  message: Text("Ви успішно додали автомобіль."),
                                  dismissButton: .default(Text("OK")) {
                                withAnimation {
                                    selectedTab = .clientCar
                                }
                            }
                            )
                        }
                        .padding()
                        
                        HStack {
                            CustomTextField(placeholder: "Марка", input: $brand)
                        }
                        .alert(isPresented: $isAddingError) {
                            Alert(title: Text("Помилка"),
                                  message: Text("Під час додавання виникла помилка. Спробуйте, будь ласка, ще раз."),
                                  dismissButton: .default(Text("OK")))
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        
                        HStack {
                            CustomTextField(placeholder: "Модель", input: $model)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        
                        HStack {
                            CustomTextField(placeholder: "Рік випуску", input: $year)
                                .autocapitalization(.none)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        
                        VStack {
                            HStack {
                                TextField("Тип кузова:", text: $empty)
                                    .disabled(true)
                                
                                Spacer()
                                
                                Picker("Choose your role:", selection: $bodyType) {
                                    Text("Універсал").tag("Universal")
                                    Text("Седан").tag("Sedan")
                                    Text("Хетчбек").tag("Hatch-back")
                                    Text("Кросовер").tag("Crossover")
                                    Text("Купе").tag("Coupe")
                                    Text("Кабріолет").tag("Cabriolet")
                                }
                                .pickerStyle(.menu)
                                .accentColor(.secondary)
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.white)
                            }
                        )
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        
                        VStack {
                            HStack {
                                TextField("Паливо:", text: $empty)
                                    .disabled(true)
                                
                                Spacer()
                                
                                Picker("Choose your role:", selection: $fuel) {
                                    Text("Бензин").tag("Gasoline")
                                    Text("Дизель").tag("Diesel")
                                    Text("Газ").tag("Gas")
                                    Text("Газ/Бензин").tag("Gas/Gasoline")
                                    Text("Гібрид").tag("Hybrid")
                                    Text("Електро").tag("Electro")
                                }
                                .pickerStyle(.menu)
                                .accentColor(.secondary)
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.white)
                            }
                        )
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        
                        HStack {
                            CustomTextField(placeholder: "Обʼєм мотору", input: $engineCapacity)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        
                        VStack {
                            HStack {
                                TextField("КПП:", text: $empty)
                                    .disabled(true)
                                
                                Spacer()
                                
                                Picker("Choose your role:", selection: $transmission) {
                                    Text("Автомат").tag("Automatic")
                                    Text("Ручна/механіка").tag("Manual")
                                    Text("Типтронік").tag("Tiptronic")
                                    Text("Робот").tag("Robot")
                                    Text("Варіатор").tag("Variator")
                                }
                                .pickerStyle(.menu)
                                .accentColor(.secondary)
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(Color.white)
                            }
                        )
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        
                        HStack {
                            CustomTextField(placeholder: "Колір", input: $color)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        
                        HStack {
                            CustomTextField(placeholder: "Реєстраційний номер", input: $registrationNumber)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .padding(.bottom)
                        
                        Spacer()
                        
                        
                    } //: VStack
                }
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding(.vertical)
                .padding()
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        
                        if brand.isEmpty || model.isEmpty || year.isEmpty || bodyType.isEmpty || fuel.isEmpty || engineCapacity.isEmpty || transmission.isEmpty || color.isEmpty || registrationNumber.isEmpty {
                            
                            isSomeFieldIsEmpty = true
                            
                        } else {
                            
                            let tempCar = RealmCar()
                            tempCar.brand = brand
                            tempCar.model = model
                            tempCar.year = year
                            tempCar.bodyType = bodyType
                            tempCar.fuel = fuel
                            tempCar.engineCapacity = engineCapacity
                            tempCar.transmission = transmission
                            tempCar.color = color
                            tempCar.registrationNumber = registrationNumber
                            tempCar.ownerID = user!.id
                            
                            if realmManager.addCar(car: tempCar) {
                                
                                isSuccessfulAdding = true
                            } else {
                                
                                isAddingError = true
                            }
                            
                        }
                        
                    }
                }) {
                    Text("Додати")
                        .foregroundColor(.black)
                        .font(.title2)
                }
                .frame(width: 200, height: 50)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding(.bottom, 50)
                
            }
            .padding()
            
        } //: ZStack
    }
}

#Preview {
    AddCarView(selectedTab: .constant(.addCar), user: .constant(nil), car: .constant(nil))
}
