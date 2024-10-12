//
//  UserRegistrationViewModel.swift
//  GrigorenkoDemoExam
//
//  Created by user on 12.10.2024.
//

import Foundation

class UserRegistrationViewModel: ObservableObject{
    
    @Published var user = User(id: UUID(), name: "", phone: "", created_at: .now) // Данные пользователя
    
    @Published var email = "" // Email пользователя
    @Published var password = "" // Пароль пользователя
    @Published var confirmPassword = "" // Подтверждение пароля
    
    @Published var isProgress = false // Состояние загрузки при регистрации
    @Published var isNavigateToLogin = false // Состояние для навигации на экран входа
    @Published var error = false // Состояние отображения ошибки
    @Published var errorMessage = "" // Сообщение об ошибке
    
    // Функция регистрации
    func signUp(completion: @escaping (Bool) -> Void) {
        
        Task {
            do {
                // Проверка валидности email
                guard email.isValidEmail() else {
                    await MainActor.run {
                        self.errorMessage = "Invalid email format"
                        self.error = true
                    }
                    completion(false)
                    return
                }
                await MainActor.run {
                    self.isProgress = true
                }
                try await UserRepository.instance.registerUser(
                    name: user.name,
                    phone: user.phone,
                    email: email,
                    password: password
                )
                await MainActor.run {
                    self.isNavigateToLogin = true
                    self.isProgress = false
                }
                completion(true)
            } catch {
                print("ERROR: " + error.localizedDescription)
                await MainActor.run {
                    self.error = true
                    self.isProgress = false
                }
                completion(false)
            }
        }
    }
}
