//
//  ProductVNM.swift
//  estore
//
//  Created by Nadia Lovely on 13/08/24.
//

import Foundation

@MainActor
class ProductVM: ObservableObject {
    @Published var products = [ProductModel]()
    @Published var isLoading: Bool = false
    @Published var errMessage: String?
    
    @Published var filteredProducts = [ProductModel]()
    
    func loadProduct(categoryId: Int) async {
        isLoading = true
        defer { isLoading = false }
        errMessage = nil
        
        do{
            products = try await APIService.shared.fetchData(from: "products/?categoryId=\(categoryId)", returning: [ProductModel].self)
        } catch {
            errMessage = "Failed to fetch product"
            print(error)
        }
    }
    
    func addProduct(payload:  [String: Any]) async -> String {
        isLoading = true
        defer { isLoading = false }
        errMessage = nil
        
        do {
            _ = try await APIService.shared.postData(from: "products", payload: payload, response: ProductModel.self)
            return "Success add new product"
        } catch {
            errMessage = "Failed to post product"
            return "Failed to add new product"
        }
    }
    
    func searchProduct(productName: String) async {
        isLoading = true
        defer { isLoading = false }
        errMessage = nil
        
        do {
            filteredProducts = try await APIService.shared.fetchData(from: "products/?title=\(productName)", returning: [ProductModel].self)
        } catch {
            errMessage = "Failed to search"
            print(error)
        }
    }
}
