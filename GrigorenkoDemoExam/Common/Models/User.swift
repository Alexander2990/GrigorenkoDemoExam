//
//  User.swift
//  GrigorenkoDemoExam
//
//  Created by user on 12.10.2024.
//

import Foundation

struct User: Codable {
    var id: UUID = UUID() // Уникальный идентификатор пользователя
    var name: String // Имя пользователя
    var phone: String // Номер телефона пользователя
    var created_at: Date // Дата создания пользователя
}
