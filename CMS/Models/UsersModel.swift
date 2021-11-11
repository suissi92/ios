//
//  UsersModel.swift
//  CMS
//
//  Created by MacBook on 19/10/2021.
//

import Foundation

// MARK: - UsersModelElement
struct UsersModelElement: Codable {
    let id: Int
    let name, username, email, password: String
    let roles: [Role]
}

// MARK: - Role
struct Role: Codable {
    let id: Int
    let name: String
}

typealias UsersModel = [UsersModelElement]
