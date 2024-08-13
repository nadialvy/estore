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
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("CATEGORY DETAILS").font(.caption).foregroundColor(.gray)) {
                    TextField("Category Name", text: $categoryName)
                    TextField("Image URL", text: $imgUrl)
                    
                }

                Button {
                    print("hi")
                } label: {
                    Text("Create Category")
                        .foregroundStyle(.red)
                }
                
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
        
}

#Preview {
    AddCategories()
}
