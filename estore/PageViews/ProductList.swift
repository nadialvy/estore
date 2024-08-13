//
//  ProductList.swift
//  estore
//
//  Created by Nadia Lovely on 13/08/24.
//

import SwiftUI

struct ProductList: View {
    var categoryId: Int
    @StateObject private var productsVM = ProductsVM()

    var body: some View {
        NavigationStack{
            List(content: {
                ForEach(productsVM.products, id: \.id){ product in
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
                        print("helaurrr")
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .task {
            await productsVM.loadProduct(categoryId: categoryId)
        }
    }
}

#Preview {
    ProductList(
        categoryId: 1
    )
}
