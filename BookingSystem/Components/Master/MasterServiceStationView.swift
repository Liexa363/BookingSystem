//
//  MasterServiceStation.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 28.05.2024.
//

import SwiftUI

struct MasterServiceStationView: View {
    
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
    
    var body: some View {
        ZStack {
            
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    
                    Spacer()
                    
                    Text("Сервіс")
                        .font(.title)
                    
                    Spacer()
                    
                }
                .onAppear {
                    
                    isServiceStationDataLoaded = false
                    
                    DispatchQueue.main.async {
                        
                        if let serviceStationID = realmManager.getServiceStationID(byMasterEmail: user!.email) {
                            
                            serviceStation = realmManager.getServiceStation(byID: serviceStationID)
                            
                        }
                        
                        isServiceStationDataLoaded = true
                        
                    }
                    
                }
                .padding(.horizontal)
                
                ZStack {
                    
                    Color.white
                    
                    if serviceStation != nil && serviceStation?.name != "" {
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
                        
                        Text("Ви не додані до сервісу")
                            .font(.title3)
                            .foregroundStyle(.secondary)
                        
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

#Preview {
    MasterServiceStationView(selectedTab: .constant(.masterServiceStation), user: .constant(nil), serviceStation: .constant(nil))
}
