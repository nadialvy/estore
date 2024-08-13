//
//  CategoriesVM.swift
//  estore
//
//  Created by Nadia Lovely on 13/08/24.
//

import Foundation
@MainActor

class CategoriesVM: ObservableObject {
    @Published var categories = [CategoryModel]()
    @Published var isLoading: Bool = false
    @Published var errMessage: String? = ""
    
    func loadCategories() async {
        isLoading = true
        defer { isLoading = false }
        errMessage = nil
        
        do {
            categories = try await APIService.shared.fetchData(from: "categories", returning: [CategoryModel].self)
        } catch {
            errMessage = "Failed to fetch"
            print(error)
        }
    }
}


