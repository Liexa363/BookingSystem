//
//  AboutMe.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 26.04.2024.
//

import SwiftUI
import PhotosUI

struct AboutMeView: View {
    
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>) {
        self._selectedTab = selectedTab
        self._user = user
    }
    
    @EnvironmentObject var realmManager: RealmManager
    
    @State private var isExit = false
    
    @State private var image: UIImage?
    @State private var showSheet = false
    
    @State private var isImageLoaded = false
    
    var body: some View {
        ZStack {
            
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("fff")
                        .foregroundStyle(Color("backgroundColor"))
                    
                    Spacer()
                    
                    Text("Профіль")
                        .font(.title)
                    
                    Spacer()
                    
                    Button(action: {
                        
                        selectedTab = .editProfile
                        
                    }) {
                        Image(systemName: "pencil")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                            .shadow(radius: 10)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                ZStack {
                    
                    Color.white
                    
                    VStack {
                        
                        HStack {
                            
                            ZStack {
                                
                                if isImageLoaded {
                                    
                                    if let image = image {
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 150, height: 150)
                                            .cornerRadius(70)
                                            .shadow(radius: 10)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 72)
                                                    .stroke(Color.secondary, lineWidth: 3)
                                            )
                                    } else {
                                        Image(systemName: "photo")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 150, height: 150)
                                            .foregroundColor(.gray)
                                            .cornerRadius(70)
                                            .shadow(radius: 10)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 72)
                                                    .stroke(Color.secondary, lineWidth: 3)
                                            )
                                    }
                                    
                                } else {
                                    
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                        .padding()
                                    
                                }
                                
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        showSheet = true
                                    }) {
                                        Image(systemName: "camera")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.black)
                                            .shadow(radius: 10)
                                    }
                                    .padding(EdgeInsets(top: 100, leading: 0, bottom: 0, trailing: 80))
                                }
                                .sheet(isPresented: $showSheet) {
                                    
                                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image, user: user!, realmManager: realmManager)
                                }
                                .onAppear {
                                    
                                    isImageLoaded = false
                                    
                                    if let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                                        
                                        let imageName = "\(user!.id)_profile_image.jpg"
                                        
                                        let fileURL = documentsDirectory.appendingPathComponent(imageName)
                                        
                                        if let image = UIImage(contentsOfFile: fileURL.path) {
                                            
                                            self.image = image
                                            
                                            isImageLoaded = true
                                        } else {
                                            
                                            isImageLoaded = true
                                        }
                                    }
                                }
                            }
                        }
                        
                        HStack {
                            Text("Імʼя")
                                .font(.body)
                                .foregroundStyle(.secondary)
                            
                            Spacer()
                            
                            Text(user!.name)
                                .font(.body)
                        }
                        .alert(isPresented: $isExit) {
                            Alert(
                                title: Text("Повідомлення"),
                                message: Text("Ви впевнені, що хочете вийти?"),
                                primaryButton: .default(Text("Так")) {
                                    selectedTab = .suggestSignInUp
                                },
                                secondaryButton: .cancel(Text("Ні"))
                            )
                        }
                        
                        Divider().padding(.vertical)
                        
                        HStack {
                            Text("Прізвище")
                                .font(.body)
                                .foregroundStyle(.secondary)
                            
                            Spacer()
                            
                            Text(user!.surname)
                                .font(.body)
                        }
                        
                        Divider().padding(.vertical)
                        
                        HStack {
                            Text("Телефон")
                                .font(.body)
                                .foregroundStyle(.secondary)
                            
                            Spacer()
                            
                            Text(user!.phone)
                                .font(.body)
                        }
                        
                        Divider().padding(.vertical)
                        
                        HStack {
                            Text("Пошта")
                                .font(.body)
                                .foregroundStyle(.secondary)
                            
                            Spacer()
                            
                            Text(user!.email)
                                .font(.body)
                        }
                        
                        Divider().padding(.vertical)
                        
                        HStack {
                            Text("Статус")
                                .font(.body)
                                .foregroundStyle(.secondary)
                            
                            Spacer()
                            
                            Text(user!.role)
                                .font(.body)
                        }
                        
                    }
                    .padding(.horizontal)
                    .padding()
                    
                }
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding()
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        realmManager.logout()
                        
                        isExit = true
                    }
                }) {
                    Text("Вийти")
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
    AboutMeView(selectedTab: .constant(.aboutMe), user: .constant(nil))
}
