//
//  EditServiceStationView.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 21.05.2024.
//

import SwiftUI

struct EditServiceStationView: View {
    
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    @Binding private var serviceStation: ServiceStation?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>, serviceStation: Binding<ServiceStation?>) {
        self._selectedTab = selectedTab
        self._user = user
        self._serviceStation = serviceStation
    }
    
    @State private var name: String = ""
    @State private var country: String = ""
    @State private var city: String = ""
    @State private var street: String = ""
    @State private var houseNumber: String = ""
    @State private var services: [Service] = [Service(name: "", serviceDescription: "", price: "")]
    @State private var managerID: String = ""
    @State private var monday: WorkSchedule =  WorkSchedule(day: "monday", startTime: "", endTime: "")
    @State private var tuesday: WorkSchedule =  WorkSchedule(day: "tuesday", startTime: "", endTime: "")
    @State private var wednesday: WorkSchedule =  WorkSchedule(day: "wednesday", startTime: "", endTime: "")
    @State private var thursday: WorkSchedule =  WorkSchedule(day: "thursday", startTime: "", endTime: "")
    @State private var friday: WorkSchedule =  WorkSchedule(day: "friday", startTime: "", endTime: "")
    @State private var saturday: WorkSchedule =  WorkSchedule(day: "saturday", startTime: "", endTime: "")
    @State private var sunday: WorkSchedule =  WorkSchedule(day: "sunday", startTime: "", endTime: "")
    
    @State private var empty: String = ""
    
    @State private var isSomeFieldIsEmpty = false
    @State private var isSuccessfulEditing = false
    @State private var isEditingError = false
    
    @EnvironmentObject var realmManager: RealmManager
    
    @StateObject private var viewModel = ServiceStationViewModel()
    
    var body: some View {
        ZStack {
            
            Color("backgroundColor")
                .ignoresSafeArea()
            
            ScrollView {
                HStack {
                    Button(action: {
                        withAnimation {
                            selectedTab = .aboutService
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
                            Text("Редагування")
                                .font(.title)
                            
                            Spacer()
                        }
                        .alert(isPresented: $isSuccessfulEditing) {
                            Alert(title: Text("Повідомлення"),
                                  message: Text("Ви успішно відредагували інформацію про сервіс."),
                                  dismissButton: .default(Text("OK")) {
                                withAnimation {
                                    selectedTab = .aboutService
                                }
                            }
                            )
                        }
                        .padding()
                        
                        Section {
                            CustomTextField(placeholder: "Назва", input: $name)
                        }
                        .alert(isPresented: $isEditingError) {
                            Alert(title: Text("Помилка"),
                                  message: Text("Під час додавання виникла помилка. Спробуйте, будь ласка, ще раз."),
                                  dismissButton: .default(Text("OK")))
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        
                        Divider()
                            .padding(.horizontal, 20)
                        
                        Section(content: {
                            VStack(alignment: .leading) {
                                CustomTextField(placeholder: "Країна", input: $country)
                                CustomTextField(placeholder: "Місто", input: $city)
                                CustomTextField(placeholder: "Вулиця", input: $street)
                                CustomTextField(placeholder: "Номер будинку", input: $houseNumber)
                            }
                            .padding(.vertical, 5)
                        }, header: {
                            HStack {
                                Text("Адреса:")
                                    .font(.body)
                                
                                Spacer()
                            }
                        })
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        
                        Divider()
                            .padding(.horizontal, 20)
                        
                        Section(content: {
                            
                            VStack {
                                HStack {
                                    Text("Понеділок:")
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                    
                                    Spacer()
                                }
                                
                                VStack(alignment: .leading) {
                                    CustomTextField(placeholder: "Година початку роботи", input: $monday.startTime)
                                    CustomTextField(placeholder: "Година закінчення роботи", input: $monday.endTime)
                                }
                                .padding(.vertical, 5)
                            }
                            
                            VStack {
                                HStack {
                                    Text("Вівторок:")
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                    
                                    Spacer()
                                }
                                
                                VStack(alignment: .leading) {
                                    CustomTextField(placeholder: "Година початку роботи", input: $tuesday.startTime)
                                    CustomTextField(placeholder: "Година закінчення роботи", input: $tuesday.endTime)
                                }
                                .padding(.vertical, 5)
                            }
                            
                            VStack {
                                HStack {
                                    Text("Середа:")
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                    
                                    Spacer()
                                }
                                
                                VStack(alignment: .leading) {
                                    CustomTextField(placeholder: "Година початку роботи", input: $wednesday.startTime)
                                    CustomTextField(placeholder: "Година закінчення роботи", input: $wednesday.endTime)
                                }
                                .padding(.vertical, 5)
                            }
                            
                            VStack {
                                HStack {
                                    Text("Четвер:")
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                    
                                    Spacer()
                                }
                                
                                VStack(alignment: .leading) {
                                    CustomTextField(placeholder: "Година початку роботи", input: $thursday.startTime)
                                    CustomTextField(placeholder: "Година закінчення роботи", input: $thursday.endTime)
                                }
                                .padding(.vertical, 5)
                            }
                            
                            VStack {
                                HStack {
                                    Text("Пʼятниця:")
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                    
                                    Spacer()
                                }
                                
                                VStack(alignment: .leading) {
                                    CustomTextField(placeholder: "Година початку роботи", input: $friday.startTime)
                                    CustomTextField(placeholder: "Година закінчення роботи", input: $friday.endTime)
                                }
                                .padding(.vertical, 5)
                            }
                            
                            VStack {
                                HStack {
                                    Text("Субота:")
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                    
                                    Spacer()
                                }
                                
                                VStack(alignment: .leading) {
                                    CustomTextField(placeholder: "Година початку роботи", input: $saturday.startTime)
                                    CustomTextField(placeholder: "Година закінчення роботи", input: $saturday.endTime)
                                }
                                .padding(.vertical, 5)
                            }
                            
                            VStack {
                                HStack {
                                    Text("Неділя:")
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                    
                                    Spacer()
                                }
                                
                                VStack(alignment: .leading) {
                                    CustomTextField(placeholder: "Година початку роботи", input: $sunday.startTime)
                                    CustomTextField(placeholder: "Година закінчення роботи", input: $sunday.endTime)
                                }
                                .padding(.vertical, 5)
                            }
                            
                            
                        }, header: {
                            HStack {
                                Text("Графік роботи:")
                                    .font(.body)
                                
                                Spacer()
                            }
                        })
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        
                        Divider()
                            .padding(.horizontal, 20)
                        
                        Section(content: {
                            ForEach(viewModel.services.indices, id: \.self) { index in
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("\(index + 1).")
                                            .font(.body)
                                            .foregroundColor(.secondary)
                                        
                                        Spacer()
                                    }
                                    
                                    VStack {
                                        CustomTextField(placeholder: "Назва послуги", input: Binding(
                                            get: { viewModel.services[index].name },
                                            set: { viewModel.services[index].name = $0 }
                                        ))
                                        CustomTextField(placeholder: "Опис", input: Binding(
                                            get: { viewModel.services[index].serviceDescription },
                                            set: { viewModel.services[index].serviceDescription = $0 }
                                        ))
                                        CustomTextField(placeholder: "Ціна", input: Binding(
                                            get: { viewModel.services[index].price },
                                            set: { viewModel.services[index].price = $0 }
                                        ))
                                    }
                                    .padding(.vertical, 5)
                                }
                            }
                            .onDelete(perform: deleteService)
                            
                            Button(action: addService) {
                                Label("Додати послугу", systemImage: "plus.circle.fill")
                                    .foregroundColor(.black)
                                    .font(.body)
                            }
                        }, header: {
                            HStack {
                                Text("Послуги:")
                                    .font(.body)
                                
                                Spacer()
                            }
                        })
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        
                        Spacer()
                        
                        
                    } //: VStack
                }
                .onAppear {
//                    brand = car!.brand
//                    model = car!.model
//                    year = car!.year
//                    bodyType = car!.bodyType
//                    fuel = car!.fuel
//                    engineCapacity = car!.engineCapacity
//                    transmission = car!.transmission
//                    color = car!.color
//                    registrationNumber = car!.registrationNumber
                    
                    name = serviceStation!.name
                    country = serviceStation!.location.country
                    city = serviceStation!.location.city
                    street = serviceStation!.location.street
                    houseNumber = serviceStation!.location.houseNumber
                    
                    services = serviceStation!.services
                    
//                    for (index, service) in serviceStation!.services.enumerated() {
//                        services[index].name = serviceStation!.services[index].name
//                        services[index].serviceDescription = serviceStation!.services[index].serviceDescription
//                        services[index].price = serviceStation!.services[index].price
//                    }
                    
                    viewModel.services = serviceStation!.services
                    
                    managerID = serviceStation!.managerID
                    
                    monday = serviceStation!.workSchedule[0]
                    tuesday = serviceStation!.workSchedule[1]
                    wednesday = serviceStation!.workSchedule[2]
                    thursday = serviceStation!.workSchedule[3]
                    friday = serviceStation!.workSchedule[4]
                    saturday = serviceStation!.workSchedule[5]
                    sunday = serviceStation!.workSchedule[6]
                }
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding(.vertical)
                .padding()
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        
                        if name.isEmpty || country.isEmpty || city.isEmpty || street.isEmpty || houseNumber.isEmpty || viewModel.services[0].name.isEmpty || viewModel.services[0].serviceDescription.isEmpty || viewModel.services[0].price.isEmpty || monday.startTime.isEmpty || monday.endTime.isEmpty || tuesday.startTime.isEmpty || tuesday.endTime.isEmpty || wednesday.startTime.isEmpty || wednesday.endTime.isEmpty || thursday.startTime.isEmpty || thursday.endTime.isEmpty || friday.startTime.isEmpty || friday.endTime.isEmpty || saturday.startTime.isEmpty || saturday.endTime.isEmpty || sunday.startTime.isEmpty || sunday.endTime.isEmpty {
                            
                            isSomeFieldIsEmpty = true
                            
                        } else {
                            
                            let tempLocation = Location(country: country, city: city, street: street, houseNumber: houseNumber)
                            
                            var tempServices: [Service] = [Service(name: "", serviceDescription: "", price: "")]
                            tempServices.removeAll()
                            for (index, service) in viewModel.services.enumerated() {
                                let tempService = Service(name: service.name, serviceDescription: service.serviceDescription, price: service.price)
                                
                                tempServices.append(tempService)
                            }
                            
                            var tempWorkSchedule: [WorkSchedule] = [WorkSchedule(day: "", startTime: "", endTime: "")]
                            let tempMonday = WorkSchedule(day: monday.day, startTime: monday.startTime, endTime: monday.endTime)
                            let tempTuesday = WorkSchedule(day: tuesday.day, startTime: tuesday.startTime, endTime: tuesday.endTime)
                            let tempWendesday = WorkSchedule(day: wednesday.day, startTime: wednesday.startTime, endTime: wednesday.endTime)
                            let tempThursday = WorkSchedule(day: thursday.day, startTime: thursday.startTime, endTime: thursday.endTime)
                            let tempFriday = WorkSchedule(day: friday.day, startTime: friday.startTime, endTime: friday.endTime)
                            let tempSaturday = WorkSchedule(day: saturday.day, startTime: saturday.startTime, endTime: saturday.endTime)
                            let tempSunday = WorkSchedule(day: sunday.day, startTime: sunday.startTime, endTime: sunday.endTime)
                            
                            tempWorkSchedule.removeAll()
                            tempWorkSchedule.append(tempMonday)
                            tempWorkSchedule.append(tempTuesday)
                            tempWorkSchedule.append(tempWendesday)
                            tempWorkSchedule.append(tempThursday)
                            tempWorkSchedule.append(tempFriday)
                            tempWorkSchedule.append(tempSaturday)
                            tempWorkSchedule.append(tempSunday)
                            
                            let tempServiceStation = ServiceStation(id: "", name: name, location: tempLocation, services: tempServices, managerID: user!.id, workSchedule: tempWorkSchedule)
                            
                            
                            if realmManager.editServiceStation(withNewServiceStationData: tempServiceStation) {

                                isSuccessfulEditing = true
                            } else {

                                isEditingError = true
                            }
                            
                        }
                        
                    }
                }) {
                    Text("Редагувати")
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
    
    private func addService() {
        viewModel.services.append(Service(name: "", serviceDescription: "", price: ""))
    }
    
    private func deleteService(at offsets: IndexSet) {
        viewModel.services.remove(atOffsets: offsets)
    }
}

#Preview {
    EditServiceStationView(selectedTab: .constant(.editServiceStation), user: .constant(nil), serviceStation: .constant(nil))
}
