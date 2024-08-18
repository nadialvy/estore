//
//  AddProduct.swift
//  estore
//
//  Created by Nadia Lovely on 17/08/24.
//

import SwiftUI

struct AddProduct: View {
    var categoryId: Int
    @State private var isSubmitting: Bool = false
    @ObservedObject var addProductForm = AddProductForm()
    @Environment(\.dismiss) var dismiss
    @StateObject private var productVM = ProductVM()
    
    var body: some View {
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
                    Task{
                        await addProduct()
                    }
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
    
    //    private func addProduct() async {
    //        isSubmitting = true
    //        let payload: [String: Any] = [
    //            "title": addProductForm.title,
    //            "price": Int(addProductForm.price)!,
    //            "description": addProductForm.description,
    //            "categoryId" : categoryId,
    //            "images":addProductForm.images
    //        ]
    //
    //        _ = await productVM.addProduct(payload: payload)
    //        isSubmitting = false
    //        dismiss()
    //        addProductForm.title = ""
    //        addProductForm.price = ""
    //        addProductForm.description = ""
    //        addProductForm.imageUrls = ""
    //
    //    }
    
    private func addProduct() async {
        isSubmitting = true
        let payload: [String: Any] = [
            "title": addProductForm.title,
            "price": Int(addProductForm.price) ?? 0,
            "description": addProductForm.description,
            "categoryId": categoryId,
            "images": addProductForm.images
        ]
        
        do {
            let newProduct = try await productVM.addProduct(payload: payload)
            print("New product added: \(newProduct)")
            isSubmitting = false
            dismiss()
            // form fields nya di reset
            addProductForm.title = ""
            addProductForm.price = ""
            addProductForm.description = ""
            addProductForm.imageUrls = ""
        } catch {
            print("Error adding product: \(error.localizedDescription)")
            isSubmitting = false
            // bisa dipasang alert disini
        }
    }
}

#Preview {
    AddProduct(categoryId: 1)
}
