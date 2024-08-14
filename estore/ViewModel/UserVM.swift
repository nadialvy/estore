//
//  UserVM.swift
//  estore
//
//  Created by Nadia Lovely on 13/08/24.
//

import Foundation
@MainActor

class UserVM: ObservableObject{
    @Published var users = [UserModel]()
    @Published var isLoading: Bool = false
    @Published var errMess: String?
    
    func loadUsers() async {
        isLoading = true
        defer { isLoading = false }
        errMess = nil
        
        do {
            users = try await APIService.shared.fetchData(from: "users", returning: [UserModel].self)
        } catch {
            errMess = "failed to fetch users data"
            print(error)
        }
    }
}
