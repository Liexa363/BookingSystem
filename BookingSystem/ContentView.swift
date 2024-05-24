//
//  ContentView.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 23.04.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab: Pages = .getStarted
    
    @EnvironmentObject var realmManager: RealmManager
    
    @State private var user: User? = nil
    
    @State private var isLogined: Bool = false
    
    @State private var isLoaded = false
    
    @State private var car: Car? = nil
    
    @State private var serviceStation: ServiceStation? = nil
    
    @State private var selectedServiceStation: ServiceStation? = nil
    
    var body: some View {
        VStack {
            
            if isLoaded {
                
                switch selectedTab {
                case .getStarted:
                    GetStartedView(selectedTab: $selectedTab)
                case .information:
                    InformationView(selectedTab: $selectedTab)
                case .suggestSignInUp:
                    SuggestSignInUpView(selectedTab: $selectedTab)
                case .signUp:
                    SignUpView(selectedTab: $selectedTab)
                case .signIn:
                    SignInView(selectedTab: $selectedTab, user: $user)
                case .clientHome:
                    ClientHomeView(selectedTab: $selectedTab, user: $user, car: $car, selectedServiceStation: $selectedServiceStation)
                case .clientBookingList:
                    ClientHomeView(selectedTab: $selectedTab, user: $user, car: $car, selectedServiceStation: $selectedServiceStation)
                case .aboutMe:
                    switch user!.role {
                    case "Manager":
                        ManagerHomeView(selectedTab: $selectedTab, user: $user, serviceStation: $serviceStation)
                    case "Master":
                        MasterHomeView(selectedTab: $selectedTab, user: $user)
                    case "Administrator":
                        AdministratorHomeView(selectedTab: $selectedTab, user: $user)
                    default:
                        ClientHomeView(selectedTab: $selectedTab, user: $user, car: $car, selectedServiceStation: $selectedServiceStation)
                    }
                case .clientCar:
                    ClientHomeView(selectedTab: $selectedTab, user: $user, car: $car, selectedServiceStation: $selectedServiceStation)
                case .masterBookingList:
                    MasterHomeView(selectedTab: $selectedTab, user: $user)
                case .managerBookingList:
                    ManagerHomeView(selectedTab: $selectedTab, user: $user, serviceStation: $serviceStation)
                case .aboutService:
                    ManagerHomeView(selectedTab: $selectedTab, user: $user, serviceStation: $serviceStation)
                case .masterUsefulContacts:
                    MasterHomeView(selectedTab: $selectedTab, user: $user)
                case .managerUsefulContacts:
                    ManagerHomeView(selectedTab: $selectedTab, user: $user, serviceStation: $serviceStation)
                case .carList:
                    AdministratorHomeView(selectedTab: $selectedTab, user: $user)
                case .serviceStationsList:
                    AdministratorHomeView(selectedTab: $selectedTab, user: $user)
                case .userList:
                    AdministratorHomeView(selectedTab: $selectedTab, user: $user)
                case .editProfile:
                    EditProfileView(selectedTab: $selectedTab, user: $user)
                case .addCar:
                    AddCarView(selectedTab: $selectedTab, user: $user, car: $car)
                case .editCar:
                    EditCarView(selectedTab: $selectedTab, user: $user, car: $car)
                case .addServiceStation:
                    AddServiceStationView(selectedTab: $selectedTab, user: $user, serviceStation: $serviceStation)
                case .editServiceStation:
                    EditServiceStationView(selectedTab: $selectedTab, user: $user, serviceStation: $serviceStation)
                case .clientAboutServiceStation:
                    AboutServiceStationView(selectedTab: $selectedTab, user: $user, selectedServiceStation: $selectedServiceStation)
                case .clientBooking:
                    ClientBookingView(selectedTab: $selectedTab, user: $user, selectedServiceStation: $selectedServiceStation)
                }
                
            } else {
                
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                
            }
            
        }
        .onAppear {
            DispatchQueue.main.async {
                isLogined = realmManager.isLogined()
                
                if isLogined {
                    
                    if let credentials = realmManager.getCredentials() {
                        
                        user = realmManager.getUser(by: credentials.email, and: credentials.password)
                        
                        if user != nil {
                            
                            switch user!.role {
                            case "Client":
                                selectedTab = .clientHome
                            case "Manager":
                                selectedTab = .managerBookingList
                            case "Master":
                                selectedTab = .masterBookingList
                            case "Administrator":
                                selectedTab = .userList
                            default:
                                selectedTab = .signIn
                            }
                            
                            isLoaded = true
                        } else {
                            
                            selectedTab = .getStarted
                            
                            isLoaded = true
                        }
                        
                    } else {
                        
                        selectedTab = .getStarted
                        
                        isLoaded = true
                    }
                    
                } else {
                    
                    selectedTab = .getStarted
                    
                    isLoaded = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
