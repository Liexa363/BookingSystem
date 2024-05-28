//
//  ManagerFeedbackList.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 28.05.2024.
//

import SwiftUI

struct ManagerFeedbackListView: View {
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    @Binding private var serviceStation: ServiceStation?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>, serviceStation: Binding<ServiceStation?>) {
        self._selectedTab = selectedTab
        self._user = user
        self._serviceStation = serviceStation
    }
    
    @EnvironmentObject var realmManager: RealmManager
    
    @State private var feedbackList: [Feedback] = Array()
    
    var body: some View {
        ZStack {
            
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Text("Відгуки")
                        .font(.title)
                }
                .onAppear {
                    
                    feedbackList = realmManager.getFeedbackList(forServiceStationWithID: serviceStation!.id)
                    
                }
                .padding(.horizontal)
                
                ZStack {
                    
                    Color.white
                    
                    if !feedbackList.isEmpty {
                        
                        ScrollView {
                            
                            VStack {
                                
                                ForEach(Array(feedbackList), id: \.id) { feedback in
                                    
                                    VStack {
                                        
                                        HStack {
                                            Text(feedback.author)
                                                .font(.body)
                                            
                                            Spacer()
                                            
                                            HStack(spacing: 2) {
                                                ForEach(0..<5) { index in
                                                    StarView(filled: index < Int(feedback.rating) ?? 0)
                                                }
                                            }
                                        }
                                        
                                        HStack {
                                            Text(feedback.date)
                                                .font(.body)
                                                .foregroundColor(.secondary)
                                            
                                            Spacer()
                                        }
                                        .padding(.bottom, 10)
                                        
                                        HStack {
                                            Text(feedback.text)
                                                .font(.body)
                                            
                                            Spacer()
                                        }
                                        
                                    }
                                    
                                    Divider().padding(.vertical, 10)
                                    
                                }
                                
                            }
                            .padding(.all, 30)
                            
                        }
                    } else {
                        
                        VStack {
                            
                            Spacer()
                            
                            HStack {
                                
                                Text("Відгуків немає")
                                    .font(.title3)
                                    .foregroundStyle(.secondary)
                                
                            }
                            
                            Spacer()
                        }
                        .padding(.all, 30)
                        
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

#Preview {
    ManagerFeedbackListView(selectedTab: .constant(.managerFeedbackList), user: .constant(nil), serviceStation: .constant(nil))
}
