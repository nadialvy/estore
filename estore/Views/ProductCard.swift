//
//  ProductCard.swift
//  estore
//
//  Created by Nadia Lovely on 13/08/24.
//

import SwiftUI

struct ProductCard: View {
    var imgUrl: String
    var name: String
    var desc: String
    var price: Int
    
    var body: some View {
        HStack{
            AsyncImage(url: URL(string: imgUrl)){ image in
                image
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(16)
            } placeholder: {
                ProgressView()
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
            }
            VStack(alignment: .leading){
                Text(name)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Text(desc)
                    .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                    .padding(.vertical, 4)
                Text("$\(price),00")
                    .foregroundStyle(.green)
            }
        }
    }
}

#Preview {
    ProductCard(imgUrl: "clothes", name: "baju kokuet", desc: "apa ya hmm ini tuh kaya hmm baju yang hehe kokuet gt loh aakk lucu banget gakuat", price: 99)
}
