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
    @State private var isDisplaySheet: Bool = false
    
    @State private var title: String = ""
    @State private var price: String = ""
    @State private var description: String = ""
    @State private var images: [String] = []

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
                        isDisplaySheet = true
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
        .sheet(isPresented: $isDisplaySheet){
            NavigationStack{
                Form{
                    Section(header: Text("PRODUCT DETAILS")) {
                        TextField("Title", text: $title)
                        TextField("Price", text: $price)
                            .keyboardType(.numberPad)
                        TextField("Description", text: $description)
                            .multilineTextAlignment(.leading)
                            .lineLimit(6)
                            .frame(height: 100)
                            .foregroundStyle(Color.clear)
                            .overlay {
                                TextEditor(text: $description)
                            }
                        HStack{
                            Text("Category ID")
                                .foregroundStyle(.gray)
                                .opacity(0.5)
                            Spacer()
                            Text("\(categoryId)")
                                .foregroundStyle(.gray)
                                .opacity(0.5)
                        }
                        TextField(
                            "Images (comma-separated URLs)",
                            text: Binding(
                                get: {
                                    images.joined(
                                        separator: ", "
                                    )
                                },
                                set: { newValue in
                                    images = newValue.split(
                                        separator: ","
                                    ).map {
                                        $0.trimmingCharacters(
                                            in: .whitespaces
                                        )
                                    }
                                }
                            )
                        )
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Create Product")
                            .foregroundStyle(.red)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .principal){
                        Text("New Product")
                            .fontWeight(.medium)
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ProductList(
        categoryId: 1
    )
}
