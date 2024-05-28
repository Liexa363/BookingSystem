//
//  CustomMultilineTextField.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 27.05.2024.
//

import SwiftUI

struct CustomMultilineTextField: View {
    var placeholder: String
    @Binding var input: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            if input.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray)
                    .padding(.all, 10)
            }
            TextEditor(text: $input)
                .padding(.all, 10)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color.white))
                )
                .frame(height: 150)
        }
    }
}

