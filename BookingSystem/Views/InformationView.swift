//
//  Information.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 23.04.2024.
//

import SwiftUI

struct InformationView: View {
    
    @Binding private var selectedTab: Pages
    
    init(selectedTab: Binding<Pages>) {
        self._selectedTab = selectedTab
    }
    
    let images = ["imageForInformation1", "imageForInformation2", "imageForInformation3"]
    let descriptions = [
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
        "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Integer posuere erat a ante venenatis dapibus posuere velit aliquet. Donec id elit non mi porta gravida at eget metus."
    ]
    
    var body: some View {
        
        ZStack {
            
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            selectedTab = .getStarted
                        }
                    }) {
                        Text("< Назад")
                            .foregroundStyle(.black)
                            .font(.title3)
                    }
                    
                    Spacer()
                }
                .padding()
                
                Spacer()
                
                ZStack {
                    TabView {
                        ForEach(images.indices, id: \.self) { index in
                            ZStack {
                                Image(images[index])
                                    .resizable()
                                    .animation(.easeInOut)
                                    .cornerRadius(20)
                                
                                VStack {
                                    HStack {
                                        Text(descriptions[index])
                                            .font(.system(size: 20))
                                            .padding(30)
                                    }
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(10)
                                    .padding(.top, 30)
                                        
                                    Spacer()
                                }
                                .padding()
                            }
                        }
                        
                    }
                    .tabViewStyle(.page)
                    .indexViewStyle(.page(backgroundDisplayMode: .always))
                    .shadow(radius: 10)
                    
                    
                    
                }
                .frame(height: 400)
                .padding(.all, 30)
                
                Spacer()
                
                HStack(alignment: .bottom) {
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            self.skip()
                        }
                    }) {
                        Text("Далі >>")
                            .foregroundColor(.black)
                            .font(.title2)
                    }
                    .frame(width: 100, height: 50)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .padding(.horizontal, 30)
                    .padding(.bottom, 50)
                    
                }
            }
            .padding()
            
        } //: ZStack
        
    }
    
    func skip() {
        selectedTab = .suggestSignInUp
    }
    
}

#Preview {
    InformationView(selectedTab: .constant(.information))
}
