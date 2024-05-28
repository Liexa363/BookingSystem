//
//  AboutServiceStationView.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 23.05.2024.
//

import SwiftUI

struct AboutServiceStationView: View {
    
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    @Binding private var selectedServiceStation: ServiceStation?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>, selectedServiceStation: Binding<ServiceStation?>) {
        self._selectedTab = selectedTab
        self._user = user
        self._selectedServiceStation = selectedServiceStation
    }
    
    @State var averageRating = 0
    
    var body: some View {
        ZStack {
            
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    
                    Button(action: {
                        withAnimation {
                            selectedTab = .clientHome
                        }
                    }) {
                        Text("< Назад")
                            .foregroundStyle(.black)
                            .font(.title3)
                    }
                    
                    Spacer()
                    
                }
                .onAppear {
                    averageRating = Int(StarView().averageRating(from: selectedServiceStation!.feedbackList) ?? 0)
                }
                .padding(.horizontal)
                
                Spacer()
                
                ZStack {
                    
                    Color.white
                    
                    ScrollView {
                        
                        VStack {
                            
                            HStack {
                                Text("Назва")
                                    .font(.body)
                                    .foregroundStyle(.secondary)
                                
                                Spacer()
                                
                                Text(selectedServiceStation!.name)
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
                                    
                                    Text(selectedServiceStation!.location.country)
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
                                    
                                    Text(selectedServiceStation!.location.city)
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
                                    
                                    Text(selectedServiceStation!.location.street)
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
                                    
                                    Text(selectedServiceStation!.location.houseNumber)
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
                                
                                ForEach(Array(selectedServiceStation!.services.enumerated()), id: \.offset) { index, service in
                                    ServiceView(service: service)
                                        .padding(.vertical, 5)
                                    if index != selectedServiceStation!.services.count - 1 {
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
                                    
                                    Text("\(selectedServiceStation!.workSchedule[0].startTime):00-\(selectedServiceStation!.workSchedule[0].endTime):00")
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
                                    
                                    Text("\(selectedServiceStation!.workSchedule[1].startTime):00-\(selectedServiceStation!.workSchedule[1].endTime):00")
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
                                    
                                    Text("\(selectedServiceStation!.workSchedule[2].startTime):00-\(selectedServiceStation!.workSchedule[2].endTime):00")
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
                                    
                                    Text("\(selectedServiceStation!.workSchedule[3].startTime):00-\(selectedServiceStation!.workSchedule[3].endTime):00")
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
                                    
                                    Text("\(selectedServiceStation!.workSchedule[4].startTime):00-\(selectedServiceStation!.workSchedule[4].endTime):00")
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
                                    
                                    Text("\(selectedServiceStation!.workSchedule[5].startTime):00-\(selectedServiceStation!.workSchedule[5].endTime):00")
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
                                    
                                    Text("\(selectedServiceStation!.workSchedule[6].startTime):00-\(selectedServiceStation!.workSchedule[6].endTime):00")
                                        .font(.body)
                                }
                            }
                            
                            Divider().padding(.vertical, 10)
                            
                            Button(action: {
                                
                                selectedTab = .clientFeedbackList
                                
                            }) {
                                
                                HStack {
                                    Text("Відгуків: \(selectedServiceStation!.feedbackList.count)")
                                        .font(.body)
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                    
                                    HStack(spacing: 2) {
                                        ForEach(0..<5) { index in
                                            StarView(filled: index < averageRating)
                                        }
                                    }
                                    
                                    Image(systemName: "arrow.right.square")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.black)
                                        .padding(.leading)
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
                
                Button(action: {
                    withAnimation {
                        
                        selectedTab = .clientBooking
                        
                    }
                }) {
                    Text("Забронювати")
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


#Preview {
    AboutServiceStationView(selectedTab: .constant(.clientAboutServiceStation), user: .constant(nil), selectedServiceStation: .constant(nil))
}
