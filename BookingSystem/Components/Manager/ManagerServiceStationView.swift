//
//  ManagerServiceView.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 21.05.2024.
//

import SwiftUI

struct ManagerServiceStationView: View {
    
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    @Binding private var serviceStation: ServiceStation?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>, serviceStation: Binding<ServiceStation?>) {
        self._selectedTab = selectedTab
        self._user = user
        self._serviceStation = serviceStation
    }
    
    @EnvironmentObject var realmManager: RealmManager
    
    @State private var isServiceStationDataLoaded = false
    
    @State private var selectedItem: Int = 0
    
    @State private var masterEmails: [String] = Array()
    
    @State private var isServiceStationNotExist = false
    @State private var isSuccessfulRefresh = false
    @State private var isRefreshError = false
    
    @State private var isTypingDisabled: Bool = false
    
    var body: some View {
        ZStack {
            
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    
                    if selectedItem == 0 {
                        Text("ffii")
                            .foregroundStyle(Color("backgroundColor"))
                    }
                    
                    Spacer()
                    
                    Text("Сервіс")
                        .font(.title)
                    
                    Spacer()
                    
                    if selectedItem == 0 {
                        
                        if realmManager.isServiceStationExists(forManagerID: user!.id) {
                            Button(action: {
                                
                                withAnimation {
                                    
                                    selectedTab = .editServiceStation
                                    
                                }
                                
                            }) {
                                Image(systemName: "pencil")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.black)
                                    .shadow(radius: 10)
                            }
                        } else {
                            Button(action: {
                                
                                withAnimation {
                                    
                                    selectedTab = .addServiceStation
                                    
                                }
                                
                            }) {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.black)
                                    .shadow(radius: 10)
                            }
                        }
                    }
                }
                .alert(isPresented: $isSuccessfulRefresh) {
                    Alert(title: Text("Повідомлення"),
                          message: Text("Ви успішно оновили список майстрів."),
                          dismissButton: .default(Text("OK")) {
                        withAnimation {
                            isTypingDisabled = false
                        }
                    }
                    )
                }
                .padding(.horizontal)
                
                HStack {
                    
                }
                .disabled(true)
                .alert(isPresented: $isRefreshError) {
                    Alert(title: Text("Помилка"),
                          message: Text("Під час оновлення даних виникла помилка. Спробуйте, будь ласка, ще раз."),
                          dismissButton: .default(Text("OK")))
                }
                
                HStack {
                    HStack(spacing: 0) {
                        MenuItem(title: "Сервіс", isSelected: selectedItem == 0) {
                            selectedItem = 0
                        }
                        
                        MenuItem(title: "Майстри", isSelected: selectedItem == 1) {
                            selectedItem = 1
                        }
                    }
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                }
                .onAppear {
                    
                    isServiceStationDataLoaded = false
                    
                    DispatchQueue.main.async {
                        
                        if let tempServiceStation = realmManager.getServiceStation(byManagerID: user!.id) {
                            
                            serviceStation = tempServiceStation
                            
                            isServiceStationDataLoaded = true
                        }
                        
                    }
                    
                    if serviceStation != nil {
                        masterEmails = realmManager.getMasterEmails(byServiceStationID: serviceStation!.id)
                    }
                    
                }
                .alert(isPresented: $isServiceStationNotExist) {
                    Alert(
                        title: Text("Помилка"),
                        message: Text("Щоб додати майстрів, спочатку, будь ласка, додайте інформацію про сервіс та спробуйте ще раз."),
                        dismissButton: .default(Text("OK")))
                }
                .shadow(radius: 10)
                .padding(.horizontal)
                .padding(.top)
                
                if selectedItem == 0 {
                    
                    ZStack {
                        
                        Color.white
                        
                        if realmManager.isServiceStationExists(forManagerID: user!.id) {
                            ScrollView {
                                
                                if isServiceStationDataLoaded {
                                    
                                    VStack {
                                        
                                        HStack {
                                            Text("Назва")
                                                .font(.body)
                                                .foregroundStyle(.secondary)
                                            
                                            Spacer()
                                            
                                            Text(serviceStation!.name)
                                                .font(.body)
                                        }
                                        
                                        Divider().padding(.vertical, 10)
                                        
                                        VStack {
                                            HStack {
                                                Text("Адреса:")
                                                    .font(.body)
                                                
                                                Spacer()
                                            }
                                            .padding(.bottom, 10)
                                            
                                            HStack {
                                                Text("Країна")
                                                    .font(.body)
                                                    .foregroundStyle(.secondary)
                                                
                                                Spacer()
                                                
                                                Text(serviceStation!.location.country)
                                                    .font(.body)
                                            }
                                            
                                            Divider()
                                                .padding(.vertical, 1)
                                                .padding(.horizontal, 20)
                                            
                                            HStack {
                                                Text("Місто")
                                                    .font(.body)
                                                    .foregroundStyle(.secondary)
                                                
                                                Spacer()
                                                
                                                Text(serviceStation!.location.city)
                                                    .font(.body)
                                            }
                                            
                                            Divider()
                                                .padding(.vertical, 1)
                                                .padding(.horizontal, 20)
                                            
                                            HStack {
                                                Text("Вулиця")
                                                    .font(.body)
                                                    .foregroundStyle(.secondary)
                                                
                                                Spacer()
                                                
                                                Text(serviceStation!.location.street)
                                                    .font(.body)
                                            }
                                            
                                            Divider()
                                                .padding(.vertical, 1)
                                                .padding(.horizontal, 20)
                                            
                                            HStack {
                                                Text("Номер будинку")
                                                    .font(.body)
                                                    .foregroundStyle(.secondary)
                                                
                                                Spacer()
                                                
                                                Text(serviceStation!.location.houseNumber)
                                                    .font(.body)
                                            }
                                        }
                                        
                                        Divider().padding(.vertical, 10)
                                        
                                        VStack {
                                            HStack {
                                                Text("Послуги:")
                                                    .font(.body)
                                                
                                                Spacer()
                                            }
                                            .padding(.bottom, 10)
                                            
                                            ForEach(Array(serviceStation!.services.enumerated()), id: \.offset) { index, service in
                                                ServiceView(service: service)
                                                    .padding(.vertical, 5)
                                                if index != serviceStation!.services.count - 1 {
                                                    Divider()
                                                        .padding(.vertical, 1)
                                                        .padding(.horizontal, 20)
                                                }
                                            }
                                        }
                                        
                                        Divider().padding(.vertical, 10)
                                        
                                        VStack {
                                            HStack {
                                                Text("Графік роботи:")
                                                    .font(.body)
                                                
                                                Spacer()
                                            }
                                            .padding(.bottom, 10)
                                            
                                            HStack {
                                                Text("Понеділок")
                                                    .font(.body)
                                                    .foregroundStyle(.secondary)
                                                
                                                Spacer()
                                                
                                                Text("\(serviceStation!.workSchedule[0].startTime):00-\(serviceStation!.workSchedule[0].endTime):00")
                                                    .font(.body)
                                            }
                                            
                                            Divider()
                                                .padding(.vertical, 1)
                                                .padding(.horizontal, 20)
                                            
                                            HStack {
                                                Text("Вівторок")
                                                    .font(.body)
                                                    .foregroundStyle(.secondary)
                                                
                                                Spacer()
                                                
                                                Text("\(serviceStation!.workSchedule[1].startTime):00-\(serviceStation!.workSchedule[1].endTime):00")
                                                    .font(.body)
                                            }
                                            
                                            Divider()
                                                .padding(.vertical, 1)
                                                .padding(.horizontal, 20)
                                            
                                            HStack {
                                                Text("Середа")
                                                    .font(.body)
                                                    .foregroundStyle(.secondary)
                                                
                                                Spacer()
                                                
                                                Text("\(serviceStation!.workSchedule[2].startTime):00-\(serviceStation!.workSchedule[2].endTime):00")
                                                    .font(.body)
                                            }
                                            
                                            Divider()
                                                .padding(.vertical, 1)
                                                .padding(.horizontal, 20)
                                            
                                            HStack {
                                                Text("Четвер")
                                                    .font(.body)
                                                    .foregroundStyle(.secondary)
                                                
                                                Spacer()
                                                
                                                Text("\(serviceStation!.workSchedule[3].startTime):00-\(serviceStation!.workSchedule[3].endTime):00")
                                                    .font(.body)
                                            }
                                            
                                            Divider()
                                                .padding(.vertical, 1)
                                                .padding(.horizontal, 20)
                                            
                                            HStack {
                                                Text("Пʼятниця")
                                                    .font(.body)
                                                    .foregroundStyle(.secondary)
                                                
                                                Spacer()
                                                
                                                Text("\(serviceStation!.workSchedule[4].startTime):00-\(serviceStation!.workSchedule[4].endTime):00")
                                                    .font(.body)
                                            }
                                            
                                            Divider()
                                                .padding(.vertical, 1)
                                                .padding(.horizontal, 20)
                                            
                                            HStack {
                                                Text("Субота")
                                                    .font(.body)
                                                    .foregroundStyle(.secondary)
                                                
                                                Spacer()
                                                
                                                Text("\(serviceStation!.workSchedule[5].startTime):00-\(serviceStation!.workSchedule[5].endTime):00")
                                                    .font(.body)
                                            }
                                            
                                            Divider()
                                                .padding(.vertical, 1)
                                                .padding(.horizontal, 20)
                                            
                                            HStack {
                                                Text("Неділя")
                                                    .font(.body)
                                                    .foregroundStyle(.secondary)
                                                
                                                Spacer()
                                                
                                                Text("\(serviceStation!.workSchedule[6].startTime):00-\(serviceStation!.workSchedule[6].endTime):00")
                                                    .font(.body)
                                            }
                                        }
                                        
                                    }
                                    .padding(.all, 30)
                                    
                                } else {
                                    
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                        .padding()
                                    
                                }
                                
                            }
                        } else {
                            
                            Text("Сервіс не доданий")
                                .font(.title3)
                                .foregroundStyle(.secondary)
                            
                        }
                        
                    }
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .padding(.horizontal)
                    .padding(.bottom)
                    .padding(.top, 5)
                    
                } else {
                    
                    ZStack {
                        
                        Color.white
                        
                        ScrollView {
                            
                            VStack {
                                
                                HStack {
                                    Text("Електронні пошти:")
                                        .font(.body)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        
                                        masterEmails.append("")
                                        
                                    }) {
                                        Image(systemName: "plus")
                                            .resizable()
                                            .frame(width: 15, height: 15)
                                            .foregroundColor(.black)
                                            .shadow(radius: 10)
                                    }
                                }
                                .padding(.bottom)
                                
                                VStack {
                                    ForEach(0..<masterEmails.count, id: \.self) { index in
                                        HStack {
                                            Text("\(index + 1).")
                                                .font(.body)
                                            
                                            TextField("Пошта", text: Binding(
                                                get: { self.masterEmails[index] },
                                                set: { self.masterEmails[index] = $0 }
                                            ))
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .autocapitalization(.none)
                                            .disableAutocorrection(true)
                                            .disabled(isTypingDisabled)
                                            .padding(.vertical, 4)
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                // Remove the text field
                                                masterEmails.remove(at: index)
                                            }) {
                                                Image(systemName: "trash")
                                                    .foregroundColor(.red)
                                            }
                                        }
                                    }
                                }
                                
                                Spacer()
                                
                            }
                            .padding(.all, 30)
                            
                        }
                    }
                    .cornerRadius(20)
                    .shadow(radius: 10)
                    .padding(.horizontal)
                    .padding(.bottom)
                    .padding(.top, 5)
                    
                    Button(action: {
                        withAnimation {
                            
                            if serviceStation == nil {
                                
                                isServiceStationNotExist = true
                                
                            } else {
                                
                                if realmManager.refreshMasterEmails(forServiceStationID: serviceStation!.id, newEmails: masterEmails) {
                                    
                                    isTypingDisabled = true
                                    
                                    isSuccessfulRefresh = true
                                    
                                } else {
                                    
                                    isRefreshError = true
                                    
                                }
                                
                            }
                            
                        }
                    }) {
                        Text("Зберегти")
                            .foregroundColor(.black)
                            .font(.title2)
                    }
                    .frame(width: 200, height: 50)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding()
                    
                }
            }
        }
    }
}

struct ServiceView: View {
    var service: Service

    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Назва:")
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
                
                HStack {
                    Text(service.name)
                        .font(.body)
                    
                    Spacer()
                }
            }
            .padding(.bottom, 5)
            
            VStack {
                HStack {
                    Text("Опис:")
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
                
                HStack {
                    Text(service.serviceDescription)
                        .font(.body)
                    
                    Spacer()
                }
            }
            .padding(.bottom, 5)
            
            VStack {
                HStack {
                    Text("Ціна:")
                        .font(.body)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                }
                
                HStack {
                    Text("\(service.price) грн")
                        .font(.body)
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ManagerServiceStationView(selectedTab: .constant(.aboutService), user: .constant(nil), serviceStation: .constant(nil))
}
