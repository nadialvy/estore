//
//  ProductDetail.swift
//  estore
//
//  Created by Nadia Lovely on 13/08/24.
//

import SwiftUI

struct ProductDetail: View {
    var body: some View {
        NavigationStack{
            VStack{
                Text("Baju Coquette Warna Pink")
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        AsyncImage(url: URL(string: "hehe")){ image in
                            image
                                .resizable()
                                .frame(width: 120, height: 120)
                                .cornerRadius(12)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 120, height: 120)
                        }
                        Image("clothes")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .cornerRadius(12)
                        Image("clothes")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .cornerRadius(12)
                        Image("clothes")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .cornerRadius(12)
                    }
                }
                GroupBox {
                    VStack(alignment: .leading){
                        HStack{
                            Image(systemName: "info.circle.fill")
                            Text("Product Info")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                        Text("Price: $99,00")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.vertical, 8)
                        Text("Description: ")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text("- apa ya")
                    }
                    .frame(
                          minWidth: 0,
                          maxWidth: .infinity,
                          minHeight: 0,
                          maxHeight: .infinity,
                          alignment: .topLeading
                        )
                }
                .padding(.vertical)
                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal) {
                    Text("Details")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                }
            }
        }
    }
}

#Preview {
    ProductDetail()
}
