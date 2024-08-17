//
//  Search.swift
//  estore
//
//  Created by Nadia Lovely on 12/08/24.
//

import SwiftUI

struct Search: View {
    @StateObject private var productVM = ProductVM()
    @StateObject private var debounceState = DebounceState(initialValue: "")
    
    var body: some View {
        NavigationStack{
            VStack{
                if(productVM.filteredProducts.isEmpty || debounceState.debouncedInput.isEmpty){
                    ContentUnavailableView.search
                } else {
                    List(productVM.filteredProducts, id:\.id){ product in
                        NavigationLink{
                            ProductDetail(productId: product.id)
                        } label: {
                            ProductCard(imgUrl: product.images[0], name: product.title, desc: product.description, price: product.price)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Search")
                        .fontWeight(.medium)
                }
            }
        }
        .searchable(text: $debounceState.currentValue, prompt: "Search product")
        .onChange(of: debounceState.debouncedInput) {
            Task {
                await productVM.searchProduct(productName: debounceState.debouncedInput)
            }
        }
    }
}

#Preview {
    Search()
}
