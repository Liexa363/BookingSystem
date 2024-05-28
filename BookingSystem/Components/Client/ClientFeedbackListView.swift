//
//  ClientFeedbackList.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 27.05.2024.
//

import SwiftUI

struct ClientFeedbackListView: View {
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    @Binding private var selectedServiceStation: ServiceStation?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>, selectedServiceStation: Binding<ServiceStation?>) {
        self._selectedTab = selectedTab
        self._user = user
        self._selectedServiceStation = selectedServiceStation
    }
    
    @EnvironmentObject var realmManager: RealmManager
    
    @State private var feedbackList: [Feedback] = Array()
    
    var body: some View {
        ZStack {
            
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    
                    Button(action: {
                        withAnimation {
                            selectedTab = .clientAboutServiceStation
                        }
                    }) {
                        Text("< Назад")
                            .foregroundStyle(.black)
                            .font(.title3)
                    }
                    
                    Spacer()
                    
                }
                .onAppear {
                    
                    feedbackList = realmManager.getFeedbackList(forServiceStationWithID: selectedServiceStation!.id)
                    
                }
                .padding(.horizontal)
                
                Spacer()
                
                ZStack {
                    
                    Color.white
                    
                    if !feedbackList.isEmpty {
                        
                        ScrollView {
                            
                            VStack {
                                
                                HStack {
                                    Text("Відгуки:")
                                        .font(.title2)
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        
                                        selectedTab = .clientAddFeedback
                                        
                                    }) {
                                        Label("Додати відгук", systemImage: "plus.circle.fill")
                                            .foregroundColor(.black)
                                            .font(.body)
                                    }
                                }
                                .padding(.bottom)
                                
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
                            HStack {
                                Text("Відгуки:")
                                    .font(.title2)
                                
                                Spacer()
                                
                                Button(action: {
                                    
                                    selectedTab = .clientAddFeedback
                                    
                                }) {
                                    Label("Додати відгук", systemImage: "plus.circle.fill")
                                        .foregroundColor(.black)
                                        .font(.body)
                                }
                            }
                            .padding(.bottom)
                            
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
                .padding(.vertical)
                .padding()
                
            }
        }
    }
}

#Preview {
    ClientFeedbackListView(selectedTab: .constant(.clientFeedbackList), user: .constant(nil), selectedServiceStation: .constant(nil))
}
