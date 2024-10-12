//
//  ForgotPasswordView.swift
//  GrigorenkoDemoExam
//
//  Created by user on 12.10.2024.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    // MARK: Private property
    @State private var email = "" // Email для восстановления пароля
    @State private var isLoading = false
    
    @State private var isErrorPresented = false // Состояние отображения ошибки
    @State private var navigateToOTP = false
    
    // MARK: Body
    var body: some View {
        
        VStack(alignment: .leading, spacing: 40) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Forgot Password")
                    .applyRobotoFont(size: 24, weight: .medium)
                    .foregroundStyle(.black)
                Text("Enter your email address")
                    .applyRobotoFont(size: 14, weight: .medium)
                    .foregroundStyle(.gray)
            }
            
            // Поле для ввода email
            LabeledTextField(
                title: "Email Address",
                placeholder: "***********@mail.com",
                userInput: $email
            )
            
            VStack(spacing: 18) {
                Button("Send OTP") {
                    // Логика отправки OTP
                    navigateToOTP = true
                }.buttonStyle(CustomButtonStyle(isLoading: isLoading))
                
                VStack(spacing: 6) {
                    HStack(spacing: 4) {
                        Text("Remember password? Back to")
                            .applyRobotoFont(size: 14, weight: .regular)
                            .foregroundColor(.gray)
                        NavigationLink {
                            LoginView()
                        } label: {
                            Text("Sign In")
                                .foregroundColor(.accentColor)
                                .applyRobotoFont(size: 14, weight: .medium)
                        }
                        .foregroundColor(.accentColor)
                        .tint(.accentColor)
                    }
                }
            }
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
        .navigationBarHidden(true)
        .background(
            NavigationLink(destination: OTPVerificationView(), isActive: $navigateToOTP) {
                EmptyView()
            }
                .hidden() // скрываем NavigationLink
        )
    }
}

#Preview {
    ForgotPasswordView()
}
