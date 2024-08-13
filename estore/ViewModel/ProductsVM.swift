//
//  ProductVNM.swift
//  estore
//
//  Created by Nadia Lovely on 13/08/24.
//

import Foundation

class ProductsVM: ObservableObject {
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
}
