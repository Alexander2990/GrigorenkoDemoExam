//
//  ContentView.swift
//  GrigorenkoDemoExam
//
//  Created by user on 12.10.2024.
//
// Ссылка на проект GitHub: https://github.com/Alexander2990/GrigorenkoDemoExam.git

import SwiftUI

struct SignUpView: View {
    
    // MARK: Private property
    @State private var isTermsAccepted = false // Состояние для отслеживания принятия условий
    @State private var isEmailInvalid = false // Состояние для отслеживания валидности email
    @State private var isProgress = false // Состояние для отображения процесса загрузки
    @State private var showAlert = false // Состояние для отображения алерта
    
    @StateObject var signUpViewModel = UserRegistrationViewModel() // Модель представления для регистрации пользователя
    
    // Проверка валидности формы регистрации
    private var isFormValid: Bool {
        return !signUpViewModel.user.name.isEmpty &&
        !signUpViewModel.user.phone.isEmpty &&
        !signUpViewModel.email.isEmpty &&
        !signUpViewModel.password.isEmpty &&
        !signUpViewModel.confirmPassword.isEmpty &&
        signUpViewModel.password == signUpViewModel.confirmPassword &&
        isTermsAccepted
    }
    
    // Текст условий использования и политики конфиденциальности
    private var termsAndConditionsText: some View {
        VStack {
            (
                Text("By ticking this box, you agree to our ")
                    .foregroundColor(.gray)
                + Text("Terms and Conditions and Privacy Policy")
                    .foregroundColor(.yellow)
                    .underline()
            )
            .applyRobotoFont(size: 12)
            .multilineTextAlignment(.center)
            .onTapGesture {
                // Открытие URL условий использования при нажатии
                if let url = URL(string: "https://developer.apple.com/") {
                    openURL(url)
                }
            }
            .lineLimit(nil)
            .fixedSize(horizontal: false, vertical: true)
        }
    }
    
    @Environment(\.openURL) var openURL // Переменная окружения для открытия URL
    
    // MARK: Body
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 30) {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Create an account")
                        .applyRobotoFont(size: 24, weight: .medium)
                        .foregroundStyle(.black)
                    
                    Text("Complete the sign up process to get started")
                        .applyRobotoFont(size: 14, weight: .medium)
                        .foregroundStyle(.gray)
                    
                    // Поля для ввода данных пользователя
                    LabeledTextField(
                        title: "Full name",
                        placeholder: "Ivanov Ivan",
                        userInput: $signUpViewModel.user.name
                    )
                    LabeledTextField(
                        title: "Phone Number",
                        placeholder: "+7(999)999-99-99",
                        userInput: $signUpViewModel.user.phone
                    )
                    LabeledTextField(
                        title: "Email Address",
                        placeholder: "***********@mail.com",
                        userInput: $signUpViewModel.email
                    )
                    LabeledTextField(
                        title: "Password",
                        placeholder: "**********",
                        userInput: $signUpViewModel.password,
                        isPasswordField: true
                    )
                    LabeledTextField(
                        title: "Confirm Password",
                        placeholder: "**********",
                        userInput: $signUpViewModel.confirmPassword,
                        isPasswordField: true
                    )
                }
                
                // Чекбокс для принятия условий использования
                HStack(alignment: .top, spacing: 10) {
                    StyledCheckBox(isChecked: $isTermsAccepted)
                    
                    termsAndConditionsText
                }
                
                VStack(spacing: 20) {
                    Button(action: signUpButtonTapped) {
                        if isProgress {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                        } else {
                            Text("Sign Up")
                        }
                    }
                    .buttonStyle(CustomButtonStyle(disabled: !isFormValid))
                    .disabled(!isFormValid) // Блокировка кнопки, если форма невалидна
                    
                    VStack(spacing: 8) {
                        HStack(spacing: 4) {
                            Text("Already have an account?")
                                .applyRobotoFont(size: 14, weight: .regular)
                                .foregroundColor(.gray)
                            
                            NavigationLink(destination: LoginView()) {
                                Text("Sign In")
                                    .applyRobotoFont(size: 14, weight: .medium)
                                    .foregroundColor(.accentColor)
                                    .navigationBarBackButtonHidden(false)
                            }
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
                
                // Навигация к LoginView при успешной регистрации
                NavigationLink(destination: LoginView(), isActive: $signUpViewModel.isNavigateToLogin) {
                    EmptyView()
                }
            }
            .padding(.vertical, 5)
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            .alert("Invalid Email", isPresented: $isEmailInvalid) {
                Button("OK", role: .cancel) { }
            }
        }
        .navigationBarHidden(true)
    }
    
    // MARK: Private func
    // Обработка нажатия кнопки регистрации
    private func signUpButtonTapped() {
        guard !isProgress else { return }
        
        if !signUpViewModel.email.isValidEmail() {
            isEmailInvalid = true // Показать alert о неверном формате email
        } else {
            isProgress = true
            signUpViewModel.signUp { success in
                isProgress = false
                if success {
                    signUpViewModel.isNavigateToLogin = true
                } else {
                    showAlert = true
                }
            }
        }
    }
    
    // Обработка входа через Google
    private func signInWithGoogle() {
        // Логика входа через Google
    }
}

#Preview {
    NavigationView {
        SignUpView()
    }
}
