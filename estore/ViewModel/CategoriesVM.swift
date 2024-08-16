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
            errMessage = "Failed to fetch categories"
            print(error)
        }
    }
    
    func addCategories(payload: [String: Any]) async -> String {
        isLoading = true
        defer { isLoading = false }
        errMessage = nil
                
        do {
            let newCategory = try await APIService.shared.postData(from: "categories", payload: payload, response: CategoryModel.self)
            print(newCategory)
            return "success add \(String(describing: newCategory.name))"
        } catch {
            errMessage = "Failed to add categories"
            print(error)
            return "Failed to add new category"
        }
        
        
    }
}


