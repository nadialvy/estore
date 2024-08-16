//
//  AddCategories.swift
//  estore
//
//  Created by Nadia Lovely on 12/08/24.
//

import SwiftUI

struct AddCategories: View {
    @State var categoryName: String = ""
    @State var imgUrl: String = ""
    @State private var isSubmitting: Bool = false
    @StateObject private var categoriesVM = CategoriesVM()
    @State private var isValidURL: Bool = true
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("CATEGORY DETAILS").font(.caption).foregroundColor(.gray)) {
                    TextField("Category Name", text: $categoryName)
                    VStack(alignment: .leading){
                        TextField("Image URL", text: $imgUrl)
                            .onChange(of: imgUrl){
                                isValidURL = validateImageURL(imgUrl: imgUrl)
                            }
                        if !isValidURL {
                            Text("Please enter a valid URL")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                }

                Button {
                    Task{
                        await submitData()
                    }
                } label: {
                    Text("Create Category")
                        .foregroundStyle(.red)
                }
                .disabled(isSubmitting)
                
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal) {
                    VStack{
                        Text("Add Category").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                }
            }
        }
    }
    
    private func submitData() async {
        let payload = [
            "name": categoryName,
            "image": URL(string: imgUrl)?.absoluteString ?? Constant.defaultImage
        ] as [String : Any]
        
        if(isValidURL){
            let data = await categoriesVM.addCategories(payload: payload)
//            TODO: Add modal dialogue after post
            print(data)
            categoryName = ""
            imgUrl = ""
            isValidURL = true
            dismiss()
        }
    }
        
}

#Preview {
    AddCategories()
}
