//
//  CustomSecureField.swift
//  BookingSystem
//
//  Created by Liexa MacBook Pro on 25.04.2024.
//

import SwiftUI

struct CustomSecureField: View {
    var placeholder: String
    var input: Binding<String>

    var body: some View {
        SecureField(placeholder, text: input)
            .padding(.all, 10)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black, lineWidth: 1)
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color.white)
                }
            )
    }
}

