//
//  ClientAddFeedback.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 27.05.2024.
//

import SwiftUI

struct ClientAddFeedbackView: View {
    @Binding private var selectedTab: Pages
    @Binding private var user: User?
    @Binding private var selectedServiceStation: ServiceStation?
    
    init(selectedTab: Binding<Pages>, user: Binding<User?>, selectedServiceStation: Binding<ServiceStation?>) {
        self._selectedTab = selectedTab
        self._user = user
        self._selectedServiceStation = selectedServiceStation
    }
    
    @EnvironmentObject var realmManager: RealmManager
    
    @State private var rating: String = ""
    @State private var text: String = ""
    
    @State private var isSomeFieldIsEmpty = false
    @State private var isSuccessfulAdding = false
    @State private var isAddingError = false
    
    var body: some View {
        ZStack {
            
            Color("backgroundColor")
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    
                    Button(action: {
                        withAnimation {
                            selectedTab = .clientFeedbackList
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
                .padding(.horizontal)
                
                Spacer()
                
                ZStack {
                    
                    Color.white
                    
                    ScrollView {
                        
                        VStack {
                            
                            HStack {
                                Text("Додавання")
                                    .font(.title)
                                
                                Spacer()
                            }
                            .alert(isPresented: $isSuccessfulAdding) {
                                Alert(title: Text("Повідомлення"),
                                      message: Text("Ви успішно додали відгук."),
                                      dismissButton: .default(Text("OK")) {
                                    withAnimation {
                                        selectedTab = .clientFeedbackList
                                    }
                                }
                                )
                            }
                            .padding(.bottom)
                            
                            VStack {
                                HStack {
                                    Text("Оцінка:")
                                        .font(.body)
                                    
                                    Spacer()
                                }
                                
                                HStack {
                                    CustomTextField(placeholder: "0–5", input: $rating)
                                }
                                .padding(.vertical, 5)
                            }
                            .alert(isPresented: $isAddingError) {
                                Alert(title: Text("Помилка"),
                                      message: Text("Під час додавання виникла помилка. Спробуйте, будь ласка, ще раз."),
                                      dismissButton: .default(Text("OK")))
                            }
                            .padding(.bottom)
                            
                            
                            
                            VStack {
                                HStack {
                                    Text("Відгук:")
                                        .font(.body)
                                    
                                    Spacer()
                                }
                                
                                HStack {
                                    CustomMultilineTextField(placeholder: "", input: $text)
                                }
                                .padding(.vertical, 5)
                            }
                            
                        }
                        .padding(.all, 30)
                        
                    }
                }
                .cornerRadius(20)
                .shadow(radius: 10)
                .padding(.vertical)
                .padding()
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        
                        if rating.isEmpty || text.isEmpty {
                            
                            isSomeFieldIsEmpty = true
                            
                        } else {
                            
                            let feedback = Feedback(id: "", rating: rating, text: text, date: getCurrentDateString(), author: "\(user!.surname) \(user!.name)", serviceStationID: selectedServiceStation!.id)
                            
                            if realmManager.addFeedback(toServiceStationWithID: selectedServiceStation!.id, feedback: feedback) {
                                
                                isSuccessfulAdding = true
                                
                            } else {
                                
                                isAddingError = true
                                
                            }
                            
                        }
                        
                    }
                }) {
                    Text("Додати")
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
    
    func getCurrentDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let currentDate = Date()
        return dateFormatter.string(from: currentDate)
    }
}

#Preview {
    ClientAddFeedbackView(selectedTab: .constant(.clientAddFeedback), user: .constant(nil), selectedServiceStation: .constant(nil))
}
