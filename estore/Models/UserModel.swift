//
//  UserModel.swift
//  estore
//
//  Created by Nadia Lovely on 13/08/24.
//

import Foundation

struct UserModel: Codable, Identifiable {
    var id: Int
    var email: String
    var password: String
    var name: String
    var role: String
    var avatar: String
    var creationAt: String
    var updatedAt: String
}
