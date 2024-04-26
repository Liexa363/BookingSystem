//
//  SuggestSignInUp.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 24.04.2024.
//

import SwiftUI

struct SuggestSignInUp: View {
    
    @Binding private var selectedTab: Pages
    
    init(selectedTab: Binding<Pages>) {
        self._selectedTab = selectedTab
    }
    
    var body: some View {
        ZStack {
            
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: {
                        withAnimation {
                            selectedTab = .information
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
                
                HStack {
                    Image("imageForSuggestSignInUp")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .cornerRadius(145)
                        .shadow(radius: 10)
                }
                
                Spacer()
                
                HStack {
                    Button(action: {
                        withAnimation {
                            selectedTab = .signUp
                        }
                    }) {
                        Text("Зареєструватись")
                            .foregroundColor(.black)
                            .font(.title3)
                    }
                    .frame(width: 170, height: 50)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    
                    Button(action: {
                        withAnimation {
                            selectedTab = .signIn
                        }
                    }) {
                        Text("Увійти")
                            .foregroundColor(.black)
                            .font(.title3)
                    }
                    .frame(width: 170, height: 50)
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                }
                .shadow(radius: 10)
                .padding(.bottom, 50)
            }
            .padding()
            
        }
    }
}

#Preview {
    SuggestSignInUp(selectedTab: .constant(.suggestSignInUp))
}
