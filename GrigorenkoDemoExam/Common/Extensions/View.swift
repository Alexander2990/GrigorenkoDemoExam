//
//  View.swift
//  GrigorenkoDemoExam
//
//  Created by user on 12.10.2024.
//

import SwiftUI

extension Font.Weight {
    // Соответствие между весами шрифта и Roboto
    var robotoName: String {
        switch self {
        case .black:
            return "Roboto-Black"
        case .bold:
            return "Roboto-Bold"
        case .medium:
            return "Roboto-Medium"
        default:
            return "Roboto-Regular"
        }
    }
}

extension View {
    // Применение шрифта Roboto к элементам интерфейса
    func applyRobotoFont(size: CGFloat, weight: Font.Weight = .regular) -> some View {
        self.font(.custom(weight.robotoName, size: size))
    }
}
