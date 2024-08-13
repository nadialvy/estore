//
//  Home.swift
//  estore
//
//  Created by Nadia Lovely on 12/08/24.
//

import SwiftUI

struct Home: View {
    @StateObject private var categoriesVM = CategoriesVM()
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()),]) {
                    ForEach(categoriesVM.categories, id: \.id){ item in
                        VStack{
                            AsyncImage(url: URL(string: item.image)){ image in
                                image
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(12)
                                
                            }placeholder: {
                                ProgressView()
                                    .frame(width: 100, height: 100)
                            }
                            Text(item.name)
                        }
                    }
                }
            }
            .navigationTitle("Categories")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddCategories()
                    } label: {
                        Image(systemName: "square.grid.3x1.folder.badge.plus")
                    }
                    .tint(.red)
                }
            }
        }
        .tint(.red)
        .task {
            await categoriesVM.loadCategories()
        }
        
    }
}


#Preview {
    Home()
}
