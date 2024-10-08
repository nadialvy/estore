//
//  Home.swift
//  estore
//
//  Created by Nadia Lovely on 12/08/24.
//

import SwiftUI

struct Home: View {
    @StateObject private var categoryVM = CategoryVM()
    
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()),]) {
                    ForEach(categoryVM.categories, id: \.id){ item in
                        NavigationLink {
                            ProductList(categoryId: item.id)
                        } label: {
                            VStack{
                                AsyncImage(url: URL(string: item.image)){ image in
                                    image
                                        .resizable()
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(12)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 100, height: 100)
                                }
                                Text(item.name)
                                    .foregroundStyle(.black)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Categories")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddCategory()
                    } label: {
                        Image(systemName: "square.grid.3x1.folder.badge.plus")
                    }
                    .tint(.red)
                }
            }
            .onAppear {
                Task{
                    await categoryVM.loadCategories()
                }
            }

        }
        .tint(.red)
    }
}


#Preview {
    Home()
}
