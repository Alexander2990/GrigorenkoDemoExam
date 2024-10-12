//
//  Reposetories.swift
//  GrigorenkoDemoExam
//
//  Created by user on 12.10.2024.
//

import Foundation
import Supabase

class UserRepository {
    // Синглтон для доступа к репозиторию
    static let instance = UserRepository()
    
    // Подключение к Supabase
    let supabaseClient = SupabaseClient(
        supabaseURL: URL(string: "https://hcyffmtuuraenpdishjt.supabase.co")!,
        supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhjeWZmbXR1dXJhZW5wZGlzaGp0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjg0NTQwMzQsImV4cCI6MjA0NDAzMDAzNH0.nS52Tk-xPsQu8fyWBFsgmHopW5HkgSBBtmt_LoyFETM",
        options: .init())
    
    // Регистрация пользователя в Supabase
    func registerUser(name: String, phone: String, email: String, password: String) async throws {
        
        try await supabaseClient.auth.signUp(email: email, password: password)
        let user = try await supabaseClient.auth.session.user
        let newUser = User(id: user.id, name: name, phone: phone, created_at: .now)
        
        try await supabaseClient.from("users")
            .insert(newUser)
            .execute()
        
        try await supabaseClient.auth.signOut()
    }
}
