//
//  EditProfileView.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 28.04.2024.
//

import SwiftUI

struct EditProfileView: View {
    
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>) {
        self._selectedTab = selectedTab
        self._user = user
    }
    
    @State private var name = ""
    @State private var surname = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var password = ""
    
    @State private var isSomeFieldIsEmpty = false
    @State private var isSuccessfulEditing = false
    @State private var isEditingError = false
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
                            selectedTab = .aboutMe
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
                                  message: Text("Інформацію успішно змінено."),
                                  dismissButton: .default(Text("OK")) {
                                withAnimation {
                                    selectedTab = .aboutMe
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
                        .alert(isPresented: $isEditingError) {
                            Alert(title: Text("Помилка"),
                                  message: Text("Під час редагування виникла помилка. Спробуйте, будь ласка, ще раз."),
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
                .onAppear {
                    
                    name = user!.name
                    surname = user!.surname
                    phone = user!.phone
                    email = user!.email
                    password = user!.password
                    selectedRole = user!.role
                    
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
                            
                            if realmManager.isEmailAlreadyTaken(byOtherUser: email, userId: user!.id) {
                                
                                isEmailAlreadyExist = true
                            } else {
                                
                                if realmManager.editUser(user: tempUser) {
                                    
                                    user!.name = name
                                    user!.surname = surname
                                    user!.phone = phone
                                    user!.email = email
                                    user!.password = password
                                    user!.role = selectedRole
                                    
                                    isSuccessfulEditing = true
                                } else {
                                    
                                    isEditingError = true
                                }
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
}

#Preview {
    EditProfileView(selectedTab: .constant(.editProfile), user: .constant(nil))
}
