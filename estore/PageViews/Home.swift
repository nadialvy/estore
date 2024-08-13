//
//  Home.swift
//  estore
//
//  Created by Nadia Lovely on 12/08/24.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()),]) {
                    VStack{
                        Image("clothes")
                            .resizable()
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                            .cornerRadius(12)
                        Text("Clothes")
                    }
                    VStack{
                        Image("shoes")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(12)
                        Text("Shoes")
                    }
                    VStack{
                        Image("furniture")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(12)
                        Text("Furniture")
                    }
                    VStack{
                        Image("electronic")
                            .resizable()
                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                            .cornerRadius(12)
                        Text("Electronic")
                    }
                                    }
            }
            .navigationTitle("Categories")
            .toolbar{
                ToolbarItem(
                    placement: .topBarTrailing
                ) {
                    NavigationLink {
                        AddCategories()
                    } label: {
                        Image(
                            systemName: "square.grid.3x1.folder.badge.plus"
                        )
                    }
                    .tint(
                        .red
                    )
                }
            }
        }
        .tint(.red
        )
        
    }
}


#Preview {
    Home()
}
