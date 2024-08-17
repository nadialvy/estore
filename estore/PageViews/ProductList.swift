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
    @StateObject private var productsVM = ProductsVM()
    @State private var isDisplaySheet: Bool = false
    
    
    @State private var isSubmitting: Bool = false
    
    @ObservedObject var addProductForm = AddProductForm()
    
    

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
                    Section(header: Text("PRODUCT DETAILS")){
                        TextField("Title", text: $addProductForm.title)
                            .textInputAutocapitalization(.never)
                            .validation(addProductForm.titleValidation)
                        TextField("Price", text: $addProductForm.price)
                            .validation(addProductForm.priceValidation)
                            .keyboardType(.numberPad)
                            .textInputAutocapitalization(.never)
                        TextField("Description", text: $addProductForm.description)
                            .multilineTextAlignment(.leading)
                            .lineLimit(6)
                            .frame(height: 100)
                            .foregroundStyle(Color.clear)
                            .overlay {
                                TextEditor(text: $addProductForm.description)
                            }
                            .textInputAutocapitalization(.never)
                            .validation(addProductForm.descriptionValidation)
                        HStack{
                            Text("Category ID")
                                .foregroundStyle(.gray)
                                .opacity(0.5)
                            Spacer()
                            Text("\(categoryId)")
                                .foregroundStyle(.gray)
                                .opacity(0.5)
                        }
                        TextField("Image URLs (comma-separated)", text: $addProductForm.imageUrls)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.URL)
                            .validation(addProductForm.imagesValidation)
                    }
                    Button {
                        
                    } label: {
                        Text("Create Product")
                            .foregroundStyle(.red)
                    }
                    .disabled(isSubmitting)
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
