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
        print("masuk add product")
        isLoading = true
        defer { isLoading = false }
        errMessage = nil
        
        do {
            print("masuk do")
            let newProduct = try await APIService.shared.postData(from: "products", payload: payload, response: ProductModel.self)
            print(newProduct)
            return "Success add new product"
        } catch {
            print("masuk catch")
            errMessage = "Failed to post product"
            print(error)
            return "Failed to add new product"
        }
    }
}
