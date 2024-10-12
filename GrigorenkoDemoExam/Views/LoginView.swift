//
//  LoginView.swift
//  GrigorenkoDemoExam
//
//  Created by user on 12.10.2024.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = "" // Email пользователя
    @State private var password = "" // Пароль пользователя
    
    @State private var isLoggingIn = false // Состояние загрузки при входе
    @State private var shouldNavigateToHome = false // Состояние для навигации на главный экран
    
    @State private var isRememberingPassword = false // Состояние для отслеживания запоминания пароля
    
    // Проверка валидности формы входа
    private var isFormValid: Bool {
        !email.isEmpty && !password.isEmpty
    }
    
    // Заголовок экрана входа
    private var headerSection: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            Text("Welcome Back")
                .applyRobotoFont(size: 24, weight: .medium)
                .foregroundStyle(.black)
            Text("Fill in your email and password to continue")
                .applyRobotoFont(size: 14, weight: .medium)
                .foregroundStyle(.gray)
        }
    }
    
    // Поля для ввода email и пароля
    private var inputFields: some View {
        VStack {
            LabeledTextField(
                title: "Email Address",
                placeholder: "***********@mail.com",
                userInput: $email
            )
            LabeledTextField(
                title: "Password",
                placeholder: "**********",
                userInput: $password,
                isPasswordField: true
            )
        }
    }
    
    // Опции на экране входа
    private var optionsSection: some View {
        HStack {
            HStack(alignment: .center, spacing: 5) {
                StyledCheckBox(isChecked: $isRememberingPassword)
                Text("Remember password")
                    .applyRobotoFont(size: 14, weight: .medium)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            NavigationLink {
                ForgotPasswordView()
            } label: {
                Text("Forgot password?")
                    .applyRobotoFont(size: 12, weight: .bold)
                    .foregroundColor(Color.accentColor)
            }
            
        }
    }
    
    // Кнопки для выполнения действий (вход, регистрация)
    private var actionButtons: some View {
        VStack(spacing: 20) {
            Button("Log in") {
                performLogin()
            }
            .buttonStyle(CustomButtonStyle(disabled: !isFormValid, isLoading: isLoggingIn))
            .disabled(!isFormValid)
            
            VStack(spacing: 8) {
                HStack(spacing: 3) {
                    Text("Don't have an account?")
                        .applyRobotoFont(size: 14, weight: .regular)
                        .foregroundColor(.gray)
                    NavigationLink {
                        SignUpView()
                    } label: {
                        Text("Sign Up")
                            .foregroundColor(Color.accentColor)
                            .applyRobotoFont(size: 14, weight: .medium)
                    }
                    .foregroundColor(Color.accentColor)
                    .tint(Color.accentColor)
                }
                
                Text("or sign in using")
                    .applyRobotoFont(size: 14, weight: .regular)
                    .foregroundColor(.gray)
                
                Button(action: signInWithGoogle) {
                    Image("iconeGoogle")
                        .resizable()
                        .frame(width: 16, height: 16)
                }
            }
        }
    }
    
    // Навигация к главному экрану после входа
    private var navigationLinkToHome: some View {
        NavigationLink(
            destination: HomeView(),
            isActive: $shouldNavigateToHome,
            label: {
                EmptyView()
            })
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            headerSection
            inputFields
            optionsSection
            
            Spacer().frame(height: 10)
            
            actionButtons
            navigationLinkToHome
        }
        .navigationBarHidden(true)
        .padding(.vertical, 5)
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // Обработка нажатия кнопки входа
    private func performLogin() {
        isLoggingIn = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoggingIn = false
            shouldNavigateToHome = true
        }
    }
    
    // Обработка входа через Google
    private func signInWithGoogle() {
        // Логика входа через Google
    }
}

#Preview {
    LoginView()
}

