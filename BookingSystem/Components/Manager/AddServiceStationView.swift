//
//  AddServiceStationView.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 21.05.2024.
//

import SwiftUI

struct AddServiceStationView: View {
    
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
    @State private var monday: WorkSchedule =  WorkSchedule(day: "monday", startTime: "", endTime: "", interval: "")
    @State private var tuesday: WorkSchedule =  WorkSchedule(day: "tuesday", startTime: "", endTime: "", interval: "")
    @State private var wednesday: WorkSchedule =  WorkSchedule(day: "wednesday", startTime: "", endTime: "", interval: "")
    @State private var thursday: WorkSchedule =  WorkSchedule(day: "thursday", startTime: "", endTime: "", interval: "")
    @State private var friday: WorkSchedule =  WorkSchedule(day: "friday", startTime: "", endTime: "", interval: "")
    @State private var saturday: WorkSchedule =  WorkSchedule(day: "saturday", startTime: "", endTime: "", interval: "")
    @State private var sunday: WorkSchedule =  WorkSchedule(day: "sunday", startTime: "", endTime: "", interval: "")
    
    @State private var empty: String = ""
    
    @State private var isSomeFieldIsEmpty = false
    @State private var isSuccessfulAdding = false
    @State private var isAddingError = false
    
    @EnvironmentObject var realmManager: RealmManager
    
    @StateObject private var viewModel = ServiceStationViewModel()
    
    @State private var isDelete = false
    @State private var serviceToDelete: Service?
    
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
                            Text("Додавання")
                                .font(.title)
                            
                            Spacer()
                        }
                        .alert(isPresented: $isSuccessfulAdding) {
                            Alert(title: Text("Повідомлення"),
                                  message: Text("Ви успішно додали сервіс."),
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
                        .alert(isPresented: $isAddingError) {
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
                                    CustomTextField(placeholder: "Інтервал (у хвилинах)", input: $monday.interval)
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
                                    CustomTextField(placeholder: "Інтервал (у хвилинах)", input: $tuesday.interval)
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
                                    CustomTextField(placeholder: "Інтервал (у хвилинах)", input: $wednesday.interval)
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
                                    CustomTextField(placeholder: "Інтервал (у хвилинах)", input: $thursday.interval)
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
                                    CustomTextField(placeholder: "Інтервал (у хвилинах)", input: $friday.interval)
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
                                    CustomTextField(placeholder: "Інтервал (у хвилинах)", input: $saturday.interval)
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
                                    CustomTextField(placeholder: "Інтервал (у хвилинах)", input: $sunday.interval)
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
                            ForEach(Array(viewModel.services.enumerated()), id: \.element.id) { index, service in
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text("\(index + 1).")
                                            .font(.body)
                                            .foregroundColor(.secondary)
                                        
                                        Spacer()
                                        
                                        // Delete button
                                        Button(action: {
                                            serviceToDelete = service
                                            isDelete = true
                                        }) {
                                            Image(systemName: "trash")
                                                .foregroundColor(.red)
                                        }
                                    }
                                    
                                    VStack {
                                        CustomTextField(placeholder: "Назва послуги", input: Binding(
                                            get: { service.name },
                                            set: { newValue in
                                                if let index = viewModel.services.firstIndex(where: { $0.id == service.id }) {
                                                    viewModel.services[index].name = newValue
                                                }
                                            }
                                        ))
                                        CustomTextField(placeholder: "Опис", input: Binding(
                                            get: { service.serviceDescription },
                                            set: { newValue in
                                                if let index = viewModel.services.firstIndex(where: { $0.id == service.id }) {
                                                    viewModel.services[index].serviceDescription = newValue
                                                }
                                            }
                                        ))
                                        CustomTextField(placeholder: "Ціна", input: Binding(
                                            get: { service.price },
                                            set: { newValue in
                                                if let index = viewModel.services.firstIndex(where: { $0.id == service.id }) {
                                                    viewModel.services[index].price = newValue
                                                }
                                            }
                                        ))
                                    }
                                    .padding(.vertical, 5)
                                }
                            }
                            .onDelete { indexSet in
                                viewModel.services.remove(atOffsets: indexSet)
                            }
                            .alert(isPresented: $isDelete) {
                                Alert(
                                    title: Text("Повідомлення"),
                                    message: Text("Ви впевнені, що хочете видалити послугу?"),
                                    primaryButton: .default(Text("Так")) {
                                        if let serviceToDelete = serviceToDelete {
                                            if let index = viewModel.services.firstIndex(where: { $0.id == serviceToDelete.id }) {
                                                viewModel.services.remove(at: index)
                                            }
                                        }
                                    },
                                    secondaryButton: .cancel(Text("Ні"))
                                )
                            }
                            
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
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding(.vertical)
                .padding()
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        
                        if name.isEmpty || country.isEmpty || city.isEmpty || street.isEmpty || houseNumber.isEmpty || viewModel.services[0].name.isEmpty || viewModel.services[0].serviceDescription.isEmpty || viewModel.services[0].price.isEmpty || monday.startTime.isEmpty || monday.endTime.isEmpty || tuesday.startTime.isEmpty || tuesday.endTime.isEmpty || wednesday.startTime.isEmpty || wednesday.endTime.isEmpty || thursday.startTime.isEmpty || thursday.endTime.isEmpty || friday.startTime.isEmpty || friday.endTime.isEmpty || saturday.startTime.isEmpty || saturday.endTime.isEmpty || sunday.startTime.isEmpty || sunday.endTime.isEmpty || monday.interval.isEmpty || tuesday.interval.isEmpty || wednesday.interval.isEmpty || thursday.interval.isEmpty || friday.interval.isEmpty || saturday.interval.isEmpty || sunday.interval.isEmpty {
                            
                            isSomeFieldIsEmpty = true
                            
                        } else {
                            
                            let tempServiceStation = RealmServiceStation()
                            tempServiceStation.name = name
                            tempServiceStation.location?.country = country
                            tempServiceStation.location?.city = city
                            tempServiceStation.location?.street = street
                            tempServiceStation.location?.houseNumber = houseNumber
                            
                            for (index, service) in viewModel.services.enumerated() {
                                let tempService = RealmService()
                                tempService.name = service.name
                                tempService.serviceDescription = service.serviceDescription
                                tempService.price = service.price
                                
                                tempServiceStation.services.append(tempService)
                            }
                            
                            let tempMonday = RealmWorkSchedule()
                            tempMonday.day = monday.day
                            tempMonday.startTime = monday.startTime
                            tempMonday.endTime = monday.endTime
                            tempMonday.interval = monday.interval
                            
                            let tempTuesday = RealmWorkSchedule()
                            tempTuesday.day = tuesday.day
                            tempTuesday.startTime = tuesday.startTime
                            tempTuesday.endTime = tuesday.endTime
                            tempTuesday.interval = tuesday.interval
                            
                            let tempWendesday = RealmWorkSchedule()
                            tempWendesday.day = wednesday.day
                            tempWendesday.startTime = wednesday.startTime
                            tempWendesday.endTime = wednesday.endTime
                            tempWendesday.interval = wednesday.interval
                            
                            let tempThursday = RealmWorkSchedule()
                            tempThursday.day = thursday.day
                            tempThursday.startTime = thursday.startTime
                            tempThursday.endTime = thursday.endTime
                            tempThursday.interval = thursday.interval
                            
                            let tempFriday = RealmWorkSchedule()
                            tempFriday.day = friday.day
                            tempFriday.startTime = friday.startTime
                            tempFriday.endTime = friday.endTime
                            tempFriday.interval = friday.interval
                            
                            let tempSaturday = RealmWorkSchedule()
                            tempSaturday.day = saturday.day
                            tempSaturday.startTime = saturday.startTime
                            tempSaturday.endTime = saturday.endTime
                            tempSaturday.interval = saturday.interval
                            
                            let tempSunday = RealmWorkSchedule()
                            tempSunday.day = sunday.day
                            tempSunday.startTime = sunday.startTime
                            tempSunday.endTime = sunday.endTime
                            tempSunday.interval = sunday.interval
                            
                            tempServiceStation.workSchedule.append(tempMonday)
                            tempServiceStation.workSchedule.append(tempTuesday)
                            tempServiceStation.workSchedule.append(tempWendesday)
                            tempServiceStation.workSchedule.append(tempThursday)
                            tempServiceStation.workSchedule.append(tempFriday)
                            tempServiceStation.workSchedule.append(tempSaturday)
                            tempServiceStation.workSchedule.append(tempSunday)
                            
                            tempServiceStation.managerID = user!.id
                            
                            if realmManager.addServiceStation(serviceStation: tempServiceStation) {

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
    
    private func addService() {
        viewModel.services.append(Service(name: "", serviceDescription: "", price: ""))
    }
    
}

#Preview {
    AddServiceStationView(selectedTab: .constant(.addServiceStation), user: .constant(nil), serviceStation: .constant(nil))
}

