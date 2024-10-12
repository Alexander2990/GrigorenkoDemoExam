//
//  LabeledTextField.swift
//  GrigorenkoDemoExam
//
//  Created by user on 12.10.2024.
//

import SwiftUI

struct LabeledTextField: View {
    
    let title: String // Заголовок текстового поля
    let placeholder: String // Текст-заполнитель
    let isPasswordField: Bool // Определяет, является ли поле паролем
    
    @Binding var userInput : String // Ввод пользователя
    @State private var isPasswordHidden = true // Состояние видимости пароля
    
    init(
        title: String,
        placeholder: String,
        userInput: Binding<String>,
        isPasswordField: Bool = false
    ) {
        self.title = title
        self.placeholder = placeholder
        self._userInput  = userInput
        self.isPasswordField = isPasswordField
    }
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(title)
                .applyRobotoFont(size: 14, weight: .bold)
                .foregroundColor(.gray)
            
            ZStack(alignment: .trailing) {
                Group {
                    if isPasswordField && isPasswordHidden {
                        SecureField(placeholder, text: $userInput ) // Поле для скрытого ввода пароля
                    } else {
                        TextField(placeholder, text: $userInput ) // Поле для обычного ввода
                    }
                }
                .textFieldStyle(CustomTextFieldStyle())
                
                if isPasswordField {
                    Button(action: {
                        isPasswordHidden.toggle() // Переключение видимости пароля
                    }) {
                        Image(systemName: isPasswordHidden ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing)
                }
            }
        }
    }
}

struct LabeledTextField_Previews: PreviewProvider {
    static var previews: some View {
        LabeledTextField(
            title: "Password",
            placeholder: "Enter password",
            userInput: .constant(""),
            isPasswordField: true
        )
        .padding()
    }
}
