//
//  OTPVerificationViews.swift
//  GrigorenkoDemoExam
//
//  Created by user on 12.10.2024.
//

import SwiftUI

struct OTPVerificationView: View {
    
    @State private var otpCode: [String] = Array(repeating: "", count: 6) // Массив для хранения каждой цифры OTP-кода
    @State private var timer = 60 // Таймер, инициализированный на 60 секунд
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                
                // Заголовок экрана OTP
                Text("OTP Verification")
                    .applyRobotoFont(size: 24, weight: .medium)
                    .foregroundStyle(.black)
                
                // Подзаголовок с инструкцией для пользователя
                Text("Enter the 6 digit numbers sent to your email")
                    .applyRobotoFont(size: 14, weight: .medium)
                    .foregroundStyle(.gray)
            }.padding()
            
            
            // Поля для ввода 6-значного OTP-кода
            HStack(spacing: 15) {
                ForEach(0..<6) { index in
                    TextField("", text: Binding(
                        get: { otpCode[index] }, // Получение значения для конкретного индекса массива
                        set: { newValue in
                            // Ограничиваем ввод только одной цифрой и проверяем, что это число
                            if newValue.count <= 1 && newValue.allSatisfy({ $0.isNumber }) {
                                otpCode[index] = newValue
                            }
                        }
                    ))
                    .keyboardType(.numberPad) // Используем числовую клавиатуру
                    .multilineTextAlignment(.center) // Выравнивание текста по центру
                    .applyRobotoFont(size: 14, weight: .medium) // Применение шрифта Roboto
                    .frame(width: 45, height: 45) // Задаем размер для текстового поля
                    .background(Color(UIColor.systemGray6)) // Фон текстового поля
                    .cornerRadius(8) // Закругленные углы текстового поля
                }
            }
            .frame(maxWidth: .infinity, alignment: .center) // HStack растягивается по ширине экрана
            .padding(.horizontal, 20) // Немного отступов по бокам
            
            // Таймер для повторной отправки OTP-кода
            if timer > 0 {
                Text("If you didn't receive code, resend after \(timerFormatted())")
                    .applyRobotoFont(size: 14, weight: .medium)
                    .foregroundColor(.gray)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                // Кнопка для повторной отправки кода, когда таймер истек
                Button("Resend Code") {
                    startTimer() // Запуск таймера заново
                }
                .applyRobotoFont(size: 14, weight: .medium)
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            
            // Кнопка для установки нового пароля
            Button(action: {
                // Установка нового пароля
            }) {
                Text("Set New Password")
                    .applyRobotoFont(size: 14, weight: .bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(10)
            }
            .disabled(otpCode.contains { $0.isEmpty }) // Кнопка отключена, пока все поля не заполнены
            .padding(.horizontal, 20)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: startTimer) // Запуск таймера при появлении экрана
    }
    
    // Функция для запуска таймера
    private func startTimer() {
        timer = 60
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.timer > 0 {
                self.timer -= 1 // Уменьшаем значение таймера каждую секунду
            } else {
                timer.invalidate() // Останавливаем таймер, когда он достигает нуля
            }
        }
    }
    
    // Форматирование таймера в формате MM:SS
    private func timerFormatted() -> String {
        let minutes = timer / 60
        let seconds = timer % 60
        return String(format: "%01d:%02d", minutes, seconds)
    }
}

struct OTPVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        OTPVerificationView()
    }
}
