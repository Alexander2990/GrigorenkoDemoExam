//
//  CustomButtonStyle.swift
//  GrigorenkoDemoExam
//
//  Created by user on 12.10.2024.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    let isDisabled: Bool // Состояние активности кнопки
    let width: CGFloat? // Ширина кнопки
    let isLoading: Bool // Состояние загрузки кнопки
    
    init(disabled: Bool = false, width: CGFloat? = nil, isLoading: Bool = false) {
        self.isDisabled = disabled
        self.width = width
        self.isLoading = isLoading
    }
    
    func makeBody(configuration: Configuration) -> some View {
        Group {
            if isLoading {
                // Отображение индикатора загрузки, если кнопка в состоянии загрузки
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
            } else {
                // Отображение метки кнопки, если не загружается
                configuration.label
            }
        }
        .applyRobotoFont(size: 14, weight: .bold)
        .foregroundColor(.white)
        .frame(height: 50)
        .frame(maxWidth: width ?? .infinity)
        .background(
            isDisabled ? Color.gray : // Серый цвет для неактивной кнопки
            configuration.isPressed ? Color.accentColor.opacity(0.6) : // Прозрачный цвет акцента при нажатии
                .blue // Синий цвет для активной кнопки
        )
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .opacity(isDisabled ? 0.5 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

#Preview {
    Button("Label") {
        // Действие кнопки
    }
    .buttonStyle(CustomButtonStyle())
    .padding()
}
