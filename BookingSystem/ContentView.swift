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
    
    var body: some View {
        VStack {
            
            if isLoaded {
                
                switch selectedTab {
                case .getStarted:
                    GetStarted(selectedTab: $selectedTab)
                case .information:
                    Information(selectedTab: $selectedTab)
                case .suggestSignInUp:
                    SuggestSignInUp(selectedTab: $selectedTab)
                case .signUp:
                    SignUp(selectedTab: $selectedTab)
                case .signIn:
                    SignIn(selectedTab: $selectedTab, user: $user)
                case .home:
                    Home(selectedTab: $selectedTab, user: $user)
                default:
                    Text("erroeemdmk mmcmdkdm ")
                        .font(.title)
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
                            selectedTab = .home
                            
                            isLoaded = true
                        } else {
                            
                            selectedTab = .getStarted
                            
                            isLoaded = true
                        }
                        
                    } else {
                        
                        print("No credentials found")
                        
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
