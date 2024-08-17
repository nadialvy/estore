//
//  ProductList.swift
//  estore
//
//  Created by Nadia Lovely on 13/08/24.
//

import SwiftUI
import FormValidator

struct ProductList: View {
    var categoryId: Int
    @StateObject private var productVM = ProductVM()
    @State private var isDisplaySheet: Bool = false
    
    @State private var isSubmitting: Bool = false
    
    @ObservedObject var addProductForm = AddProductForm()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack{
            List(content: {
                ForEach(productVM.products, id: \.id){ product in
                    NavigationLink{
                        ProductDetail(productId: product.id)
                    } label: {
                        ProductCard(imgUrl: "clothes", name: product.title, desc: product.description, price: product.price)
                    }
                }
            })
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Products")
                        .bold()
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        isDisplaySheet = true
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .task {
            await productVM.loadProduct(categoryId: categoryId)
        }
        .sheet(isPresented: $isDisplaySheet){
            AddProduct(categoryId: categoryId)
        }
    }
}

#Preview {
    ProductList(
        categoryId: 1
    )
}
