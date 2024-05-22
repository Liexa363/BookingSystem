//
//  UserListView.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 28.04.2024.
//

import SwiftUI

struct UserListView: View {
    
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>) {
        self._selectedTab = selectedTab
        self._user = user
    }
    
    @State private var users: [User] = Array()
    
    @EnvironmentObject var realmManager: RealmManager
    
    @State private var isDelete = false
    @State private var userForDelete = User(id: "", name: "", surname: "", phone: "", photo: "", email: "", password: "", role: "", date: "")
    
    var body: some View {
        ZStack {
            
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Користувачі")
                        .font(.title)
                }
                .padding(.horizontal)
                
                ZStack {
                    
                    Color.white
                    
                    VStack {
                        ScrollView {
                            LazyVGrid(columns: [GridItem(.flexible())]) {
                                ForEach(0..<users.count, id: \.self) { index in
                                    UserRow(user: users[index], isDelete: $isDelete, userForDelete: $userForDelete)
                                    
                                    Divider().padding(.horizontal)
                                }
                            }
                            .padding()
                        }
                        .onAppear {
                            
                            users = realmManager.getUsers()
                        }
                    }
                    
                    HStack {
                        
                    }
                    .hidden()
                    .alert(isPresented: $isDelete) {
                        Alert(
                            title: Text("Повідомлення"),
                            message: Text("Ви впевнені, що хочете видалити користувача?"),
                            primaryButton: .default(Text("Так")) {
                                if realmManager.deleteUser(withId: userForDelete.id) {
                                    users = realmManager.getUsers()
                                } else {
                                    
                                }
                            },
                            secondaryButton: .cancel(Text("Ні"))
                        )
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

struct UserRow: View {
    let user: User
    
    @State var imageName: String = ""
    
    @EnvironmentObject var realmManager: RealmManager
    
    @Binding private var isDelete: Bool
    @Binding private var userForDelete: User
    
    init(user: User, isDelete: Binding<Bool>, userForDelete: Binding<User>) {
        self.user = user
        self._isDelete = isDelete
        self._userForDelete = userForDelete
    }
    
    var body: some View {
        HStack {
            HStack {
                if user.photo.isEmpty {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .cornerRadius(3)
                        .foregroundColor(.gray)
                } else {
                    if let image = UIImage(named: imageName) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 50, height: 50)
                            .cornerRadius(3)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .cornerRadius(3)
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text("\(user.name) \(user.surname)")
                        .font(.title3)
                    Text(user.email)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            .onAppear {
                if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                    
                    let imageName = "\(user.id)_profile_image.jpg"
                    
                    let fileURL = documentsDirectory.appendingPathComponent(imageName)
                    
                    self.imageName = fileURL.path
                }
            }
            .contextMenu {
                Text("Номер телефону: \(user.phone)")
                    .font(.body)
                
                switch user.role {
                case "Client":
                    Text("Статус: клієнт")
                        .font(.body)
                case "Manager":
                    Text("Статус: менеджер")
                        .font(.body)
                case "Master":
                    Text("Статус: майстер")
                        .font(.body)
                case "Administrator":
                    Text("Статус: адміністратор")
                        .font(.body)
                default:
                    Text("Error")
                        .font(.body)
                }
            }
            
            Button(action: {
                withAnimation {
                    
                    isDelete = true
                    userForDelete = user
                    
                }
                
            }) {
                Image(systemName: "trash")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.black)
                    .shadow(radius: 10)
                    .padding(.leading)
            }
        }
        .padding(.horizontal)
        
    }
}

#Preview {
    UserListView(selectedTab: .constant(.userList), user: .constant(nil))
}
