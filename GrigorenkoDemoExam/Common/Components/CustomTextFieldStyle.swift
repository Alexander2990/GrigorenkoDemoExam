//
//  CustomTextFieldStyle.swift
//  GrigorenkoDemoExam
//
//  Created by user on 12.10.2024.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    let maxWidth: CGFloat? = nil // Максимальная ширина текстового поля
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .applyRobotoFont(size: 14, weight: .medium)
            .foregroundColor(.black)
            .frame(height: 45)
            .frame(maxWidth: maxWidth ?? .infinity)
            .padding(.leading)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
    }
}

#Preview {
    TextField("Text", text: .constant(""))
        .textFieldStyle(CustomTextFieldStyle())
        .padding()
}

