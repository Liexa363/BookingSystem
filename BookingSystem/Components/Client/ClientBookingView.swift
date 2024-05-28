//
//  ClientBookingView.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 23.05.2024.
//

import SwiftUI

struct ClientBookingView: View {
    
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    @Binding private var selectedServiceStation: ServiceStation?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>, selectedServiceStation: Binding<ServiceStation?>) {
        self._selectedTab = selectedTab
        self._user = user
        self._selectedServiceStation = selectedServiceStation
    }
    
    @State private var selectedDate = Date()
    
    @State private var weekDayNumber = 1
    @State private var schedule = ("0", "0", "0")
    
    @State private var selectedService: Service? = nil
    
    @State private var selectedTimeSlot: String? = nil
    
    @State private var selectedServiceIndex = 0
    
    @State private var isSelectedTimeSlotEmpty = false
    @State private var isSuccessfulAdding = false
    @State private var isAddingError = false
    
    @EnvironmentObject var realmManager: RealmManager
    
    @State private var bookedTimes = [""]
    
    var body: some View {
        ZStack {
            
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    
                    Button(action: {
                        withAnimation {
                            selectedTab = .clientAboutServiceStation
                        }
                    }) {
                        Text("< Назад")
                            .foregroundStyle(.black)
                            .font(.title3)
                    }
                    
                    Spacer()
                    
                }
                .onAppear {
                    weekDayNumber = weekdayNumber(from: selectedDate)
                    schedule = getWorkSchedule(for: weekDayNumber)
                    
                    selectedService = selectedServiceStation!.services[0]
                    
                    var dateToCheck: String = ""
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    dateToCheck = formatter.string(from: selectedDate)
                    
                    bookedTimes = realmManager.getBookedTimes(for: dateToCheck, serviceStationID: selectedServiceStation!.id)
                }
                .onChange(of: selectedDate, perform: { value in
                    weekDayNumber = weekdayNumber(from: selectedDate)
                    schedule = getWorkSchedule(for: weekDayNumber)
                    
                    var dateToCheck: String = ""
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd"
                    dateToCheck = formatter.string(from: selectedDate)
                    
                    bookedTimes = realmManager.getBookedTimes(for: dateToCheck, serviceStationID: selectedServiceStation!.id)
                })
                .alert(isPresented: $isSelectedTimeSlotEmpty) {
                    Alert(title: Text("Помилка"),
                          message: Text("Година для запису не вибрана. Перевірте, будь ласка, та виберіть годину."),
                          dismissButton: .default(Text("OK")))
                }
                .padding(.horizontal)
                
                Spacer()
                
                ZStack {
                    
                    Color.white
                    
                    ScrollView {
                        
                        VStack {
                            HStack {
                                TextField("Послуга:", text: .constant(""))
                                    .disabled(true)
                                
                                Spacer()
                                
                                Picker("Select a Service", selection: $selectedServiceIndex) {
                                    ForEach(0..<selectedServiceStation!.services.count, id: \.self) { index in
                                        Text(selectedServiceStation!.services[index].name).tag(index)
                                    }
                                }
                                .pickerStyle(.menu)
                                .accentColor(.secondary)
                            }
                        }
                        .alert(isPresented: $isSuccessfulAdding) {
                            Alert(title: Text("Повідомлення"),
                                  message: Text("Ви успішно забронювали запис."),
                                  dismissButton: .default(Text("OK")) {
                                withAnimation {
                                    selectedTab = .clientHome
                                }
                            }
                            )
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
                        .padding(.top, 20)
                        
                        Divider()
                            .padding(.top, 10)
                            .padding(.horizontal, 30)
                        
                        DatePicker(
                            "Select a Date",
                            selection: $selectedDate,
                            in: Date()..., // This restricts the date picker to allow dates from the current date onwards
                            displayedComponents: .date
                        )
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        
                        VStack {
                            
                            Divider()
                                .padding(.vertical, 10)
                            
                            VStack {
                                let timeSlots = generateTimeSlots(startTime: schedule.0, endTime: schedule.1, intervalMinutes: Int(schedule.2) ?? 60)
                                
                                if !timeSlots.isEmpty {
                                    HStack {
                                        Text("Години для запису:")
                                            .font(.body)
                                        
                                        Spacer()
                                    }
                                    .padding(.bottom, 10)
                                    
                                    
                                    ForEach(Array(timeSlots.enumerated()), id: \.element) { index, timeSlot in
                                        
                                        Button(action: {
                                            
                                            if selectedTimeSlot == timeSlot {
                                                selectedTimeSlot = nil
                                            } else {
                                                selectedTimeSlot = timeSlot
                                            }
                                            
                                        }) {
                                            
                                            HStack {
                                                Text(timeSlot)
                                                    .font(.body)
                                                    .foregroundColor(.secondary)
                                                
                                                Spacer()
                                                
                                                if bookedTimes.contains(timeSlot) {
                                                    Text("Зайнято")
                                                        .font(.body)
                                                        .foregroundColor(.secondary)
                                                } else {
                                                    Text("Вільно")
                                                        .font(.body)
                                                        .foregroundColor(.black)
                                                }
                                                
                                                if selectedTimeSlot == timeSlot {
                                                    Image(systemName: "checkmark")
                                                        .foregroundColor(.blue)
                                                } else {
                                                    Image(systemName: "checkmark")
                                                        .opacity(0)
                                                }
                                            }
                                            
                                        }
                                        .disabled(bookedTimes.contains(timeSlot))
                                        
                                        if index != timeSlots.count - 1 {
                                            Divider()
                                                .padding(.vertical, 1)
                                                .padding(.horizontal, 20)
                                        }
                                    }
                                } else {
                                    
                                    HStack {
                                        Text("Вихідний день")
                                            .font(.body)
                                            .foregroundColor(.secondary)
                                        
                                        Spacer()
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        .alert(isPresented: $isAddingError) {
                            Alert(title: Text("Помилка"),
                                  message: Text("Під час додавання виникла помилка. Спробуйте, будь ласка, ще раз."),
                                  dismissButton: .default(Text("OK")))
                        }
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                        
                    }
                }
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding(.vertical)
                .padding()
                
                Button(action: {
                    withAnimation {
                        
                        if selectedTimeSlot == nil {
                            
                            isSelectedTimeSlotEmpty = true
                            
                        } else {
                            
                            let tempRealmService = RealmService()
                            tempRealmService.name = selectedServiceStation!.services[selectedServiceIndex].name
                            tempRealmService.serviceDescription = selectedServiceStation!.services[selectedServiceIndex].serviceDescription
                            tempRealmService.price = selectedServiceStation!.services[selectedServiceIndex].price
                            
                            let tempRealmBookingList = RealmBooking()
                            
                            var dateToCheck: String = ""
                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy-MM-dd"
                            dateToCheck = formatter.string(from: selectedDate)
                            
                            tempRealmBookingList.date = dateToCheck
                            
                            tempRealmBookingList.time = selectedTimeSlot!
                            tempRealmBookingList.serviceStationID = selectedServiceStation!.id
                            tempRealmBookingList.clientID = user!.id
                            tempRealmBookingList.service = tempRealmService
                            
                            if realmManager.addBooking(booking: tempRealmBookingList) {

                                isSuccessfulAdding = true
                            } else {

                                isAddingError = true
                            }
                            
                        }
                        
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
    
    func weekdayNumber(from date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        
        guard let weekday = components.weekday else {
            fatalError("Could not retrieve weekday component")
        }
        
        // Convert Sunday (1) to 7, and shift the rest (2-7) down by 1 to get Monday (1) to Sunday (7)
        return (weekday == 1) ? 7 : weekday - 1
    }
    
    func getWorkSchedule(for weekday: Int) -> (startTime: String, endTime: String, interval: String) {
        // Ensure the weekday is within the valid range (1 to 7)
        guard weekday >= 1 && weekday <= 7 else { return ("0", "0", "0") }
        
        // Adjust the weekday to match the array index (0 for Monday, 1 for Tuesday, ..., 6 for Sunday)
        let index = weekday - 1
        
        let schedule = selectedServiceStation!.workSchedule[index]
        return (schedule.startTime, schedule.endTime, schedule.interval)
    }
    
    func generateTimeSlots(startTime: String, endTime: String, intervalMinutes: Int = 60) -> [String] {
        guard let startHour = Int(startTime), let endHour = Int(endTime) else {
            return []
        }
        
        if startHour == 0 && endHour == 0 && intervalMinutes == 0 {
            return []
        }
        
        var timeSlots: [String] = []
        let totalMinutesInHour = 60
        
        var currentHour = startHour
        var currentMinute = 0
        
        while currentHour < endHour || (currentHour == endHour && currentMinute < totalMinutesInHour) {
            let startSlot = String(format: "%02d:%02d", currentHour, currentMinute)
            currentMinute += intervalMinutes
            if currentMinute >= totalMinutesInHour {
                currentHour += 1
                currentMinute %= totalMinutesInHour
            }
            let endSlot = String(format: "%02d:%02d", currentHour, currentMinute)
            
            if  currentHour <= endHour {
                timeSlots.append("\(startSlot) - \(endSlot)")
            }
            
            if currentHour >= endHour && currentMinute == 0 {
                break
            }
        }
        
        return timeSlots
    }

}

#Preview {
    ClientBookingView(selectedTab: .constant(.clientBooking), user: .constant(nil), selectedServiceStation: .constant(nil))
}
