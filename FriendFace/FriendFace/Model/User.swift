//
//  User.swift
//  FriendFace
//
//  Created by Лилия Феодотова on 17.09.2023.
//

import Foundation

struct AllUsers: Codable {
    let users: [User]
}

struct User: Identifiable, Codable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
}
