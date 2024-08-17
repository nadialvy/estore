//
//  Search.swift
//  estore
//
//  Created by Nadia Lovely on 12/08/24.
//

import SwiftUI

struct Search: View {
    @StateObject private var productVM = ProductVM()
    @StateObject private var debounceState = DebounceState(initialValue: "")
    @State private var isDisplaySheet: Bool = false
    
    @State private var minPrice: String = ""
    @State private var maxPrice: String = ""
    
    @State private var selection: Int? = nil
    @StateObject private var categoryVM = CategoryVM()
    
    var body: some View {
        NavigationStack{
            VStack{
                HStack{
                    HStack{
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            TextField("Search product", text: $debounceState.currentValue)
                            .onChange(of: debounceState.debouncedInput) {
                                Task {
                                    await productVM.searchProduct(productName: debounceState.debouncedInput)
                                }
                            }
                            .textFieldStyle(PlainTextFieldStyle())
                            .padding(8)
                        }
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        
                        Button {
                            isDisplaySheet = true
                        } label: {
                            Image(systemName: "line.horizontal.3.decrease.circle")
                                .font(.title2)
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.horizontal)
                }
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
               
                if(productVM.filteredProducts.isEmpty || debounceState.debouncedInput.isEmpty){
                    ContentUnavailableView.search
                } else {
                    List(productVM.filteredProducts, id:\.id){ product in
                        NavigationLink{
                            ProductDetail(productId: product.id)
                        } label: {
                            ProductCard(imgUrl: product.images[0], name: product.title, desc: product.description, price: product.price)
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal){
                    Text("Search")
                        .fontWeight(.medium)
                }
            }
        }
        .task{
            await categoryVM.loadCategories()
        }
        .sheet(isPresented: $isDisplaySheet){
            VStack{
                VStack(alignment: .leading){
                    Text("Price Range")
                        .fontWeight(.semibold)
                    HStack(spacing: 12){
                        TextField("MIN", text: $minPrice)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("MAX", text: $maxPrice)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    Text("Category")
                        .fontWeight(.semibold)
                        .padding(.top)
                    Picker("Select Category", selection: $selection) {
                        Text("Select a Category").tag(nil as Int?)
                        
                        ForEach(categoryVM.categories, id: \.id) { item in
                            Text(item.name).tag(item.id as Int?)
                        }
                    }
                    .pickerStyle(.menu)
                    .background(Color(.white))
                    .tint(.red)
                    Button {
                        Task{
                        }
                    } label: {
                        Text("Apply Filter")
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                    }
                    .background(Color(.white))
                    .cornerRadius(12)
                    .padding(.top)
                    
                }
                .padding(.top)
                .padding(24)
                
                Spacer()
            }
            .background(Color(.systemGray6).opacity(0.5))
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    Search()
}
