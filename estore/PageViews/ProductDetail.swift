//
//  ProductDetail.swift
//  estore
//
//  Created by Nadia Lovely on 13/08/24.
//

import SwiftUI

struct ProductDetail: View {
    var productId: Int
    @StateObject private var productDetailVM = ProductDetailVM()
    var body: some View {
        NavigationStack{
            VStack{
                Text(productDetailVM.productDetail.title)
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(productDetailVM.productDetail.images, id: \.self){ img in
                            AsyncImage(url: URL(string: img)){ image in
                                image
                                    .resizable()
                                    .frame(width: 120, height: 120)
                                    .cornerRadius(12)
                            } placeholder: {
                                ProgressView()
                                    .frame(width: 120, height: 120)
                            }

                        }
                    }
                }
                GroupBox {
                    VStack(alignment: .leading){
                        HStack{
                            Image(systemName: "info.circle.fill")
                            Text("Product Info")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        }
                        Text("Price: $\(productDetailVM.productDetail.price),00")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .padding(.vertical, 8)
                        Text("Description: ")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text(productDetailVM.productDetail.description)
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
        .task {
            await productDetailVM.loadProductDetails(productId: productId)
        }
    }
}

#Preview {
    ProductDetail(productId: 28)
}
