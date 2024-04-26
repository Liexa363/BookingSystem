//
//  SignIn.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 24.04.2024.
//

import SwiftUI

struct SignIn: View {
    
    @Binding private var selectedTab: Pages
    @Binding var user: User?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>) {
        self._selectedTab = selectedTab
        self._user = user
    }
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var isSomeFieldIsEmpty = false
    @State private var isUserNotFound = false
    
    @EnvironmentObject var realmManager: RealmManager
    
    var body: some View {
        ZStack {
            
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            selectedTab = .suggestSignInUp
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
                            Text("Вхід")
                                .font(.title)
                            
                            Spacer()
                        }
                        .alert(isPresented: $isUserNotFound) {
                            Alert(title: Text("Помилка"),
                                  message: Text("Такого профілю не знайдено. Перевірте, будь ласка, чи ви ввели всі дані коректно."),
                                  dismissButton: .default(Text("OK")))
                        }
                        .padding()
                        
                        HStack {
                            CustomTextField(placeholder: "Електронна пошта", input: $email)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        
                        HStack {
                            CustomSecureField(placeholder: "Пароль", input: $password)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        
                        Spacer()
                        
                        
                    } //: VStack
                }
                .frame(width: 300, height: 250)
                .cornerRadius(20)
                .shadow(radius: 10)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        
                        if email.isEmpty || password.isEmpty {
                            
                            isSomeFieldIsEmpty = true
                        } else {
                            
                            if let tempUser = realmManager.getUser(by: email, and: password) {
                                
                                user = tempUser
                                
                                realmManager.login(by: email, password, and: tempUser.role)
                                
                                selectedTab = .home
                            } else {
                                
                                isUserNotFound = true
                            }
                        }
                    }
                }) {
                    Text("Увійти")
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
    SignIn(selectedTab: .constant(.signIn), user: .constant(nil))
}
