//
//  GetStarted.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 23.04.2024.
//

import SwiftUI

struct GetStarted: View {
    
    @Binding private var selectedTab: Pages
    
    init(selectedTab: Binding<Pages>) {
        self._selectedTab = selectedTab
    }
    
    var body: some View {
        ZStack {
            
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Image("imageForGetStarted")
                    .resizable()
                    .frame(width: 300, height: 300)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        selectedTab = .information
                    }
                }) {
                    
                    Text("Почати >")
                        .font(.title)
                        .foregroundColor(.black)
                    
                } //: button
                .frame(width: 200, height: 70)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .shadow(radius: 10)
                .padding(.bottom, 50)
                
            } //: VStack
            
            
        } //: ZStack
        
    }
}

#Preview {
    GetStarted(selectedTab: .constant(.getStarted))
}
