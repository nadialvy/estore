//
//  ProductDetail.swift
//  estore
//
//  Created by Nadia Lovely on 13/08/24.
//

import Foundation

//@MainActor
//class ProductDetailVM: ObservableObject {
//    @Published var productDetail = ProductModel(
//        id: 1,
//        title: "",
//        price: 0,
//        description: "",
//        images: [""],
//        creationAt: "",
//        updatedAt: "",
//        category: CategoryModel(
//            id: 1,
//            name: "",
//            image: ""
//        )
//    )
//    @Published var isLoading: Bool = false
//    @Published var errMess: String?
//    
//    func loadProductDetails(productId: Int) async {
//        isLoading = true
//        defer { isLoading = false }
//        errMess = nil
//        
//        do{
//            productDetail = try await APIService.shared.fetchData(
//                from: "products/\(productId)",
//                returning: ProductModel.self
//            )
//        } catch {
//            errMess = "Failed to fetch product detail"
//            print(error)
//        }
//    }
//}

@MainActor
class ProductDetailVM: ObservableObject {
    @Published var productDetail = ProductModel(
        id: 1,
        title: "",
        price: 0,
        description: "",
        images: [""],
        creationAt: "",
        updatedAt: "",
        category: CategoryModel(
            id: 1,
            name: "",
            image: ""
        )
    )
    @Published var isLoading: Bool = false
    @Published var errMess: String?
    
    func loadProductDetails(productId: Int) async {
        isLoading = true
        defer { isLoading = false }
        errMess = nil
        
        do{
            productDetail = try await APIService.shared.fetchData(
                from: "products/\(productId)",
                returning: ProductModel.self
            )
        } catch {
            errMess = "Failed to fetch product detail"
            print(error)
        }
    }
}
