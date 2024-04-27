//
//  SignUp.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 24.04.2024.
//

import SwiftUI

struct SignUpView: View {
    
    @Binding private var selectedTab: Pages
    
    init(selectedTab: Binding<Pages>) {
        self._selectedTab = selectedTab
    }
    
    @State private var name = ""
    @State private var surname = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var password = ""
    
    @State private var isSomeFieldIsEmpty = false
    @State private var isSuccessfulRegistration = false
    @State private var isRegistrationError = false
    @State private var isEmailAlreadyExist = false
    
    @EnvironmentObject var realmManager: RealmManager
    
    @State private var selectedRole: String = "Client"
    
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
                            Text("Реєстрація")
                                .font(.title)
                            
                            Spacer()
                        }
                        .alert(isPresented: $isSuccessfulRegistration) {
                            Alert(title: Text("Повідомлення"),
                                  message: Text("Ви успішно зареєструвались в системі."),
                                  dismissButton: .default(Text("OK")) {
                                withAnimation {
                                    selectedTab = .signIn
                                }
                            }
                            )
                        }
                        .padding()
                        
                        HStack {
                            CustomTextField(placeholder: "Імʼя", input: $name)
                            
                            Spacer()
                            
                            CustomTextField(placeholder: "Прізвище", input: $surname)
                        }
                        .alert(isPresented: $isRegistrationError) {
                            Alert(title: Text("Помилка"),
                                  message: Text("Під час реєстрації виникла помилка. Спробуйте, будь ласка, ще раз."),
                                  dismissButton: .default(Text("OK")))
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        
                        HStack {
                            CustomTextField(placeholder: "Номер телефону", input: $phone)
                        }
                        .alert(isPresented: $isEmailAlreadyExist) {
                            Alert(title: Text("Помилка"),
                                  message: Text("Профіль з такою електронною поштою вже існує.  Використайте, будь ласка, іншу."),
                                  dismissButton: .default(Text("OK")))
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        
                        HStack {
                            CustomTextField(placeholder: "Електронна пошта", input: $email)
                                .autocapitalization(.none)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        
                        HStack {
                            CustomSecureField(placeholder: "Пароль", input: $password)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        
                        Picker("Choose your role:", selection: $selectedRole) {
                            Text("Клієнт").tag("Client")
                            Text("Менеджер").tag("Manager")
                            Text("Майстер").tag("Master")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        
                        Spacer()
                        
                        
                    } //: VStack
                }
                .frame(width: 300, height: 400)
                .cornerRadius(20)
                .shadow(radius: 10)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        
                        if name.isEmpty || surname.isEmpty || phone.isEmpty || email.isEmpty || password.isEmpty {
                            
                            isSomeFieldIsEmpty = true
                            
                        } else {
                            
                            let tempUser = RealmUser()
                            tempUser.name = name
                            tempUser.surname = surname
                            tempUser.phone = phone
                            tempUser.email = email
                            tempUser.password = password
                            tempUser.role = selectedRole
                            
                            if realmManager.isEmailExists(email: email) {
                                
                                isEmailAlreadyExist = true
                            } else {
                                
                                if realmManager.registerUser(user: tempUser) {
                                    
                                    isSuccessfulRegistration = true
                                } else {
                                    
                                    isRegistrationError = true
                                }
                            }
                            
                        }
                        
                    }
                }) {
                    Text("Зареєструватись")
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
    SignUpView(selectedTab: .constant(.signUp))
}
