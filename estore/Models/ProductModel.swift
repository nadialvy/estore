//
//  ProductModel.swift
//  estore
//
//  Created by Nadia Lovely on 13/08/24.
//

import Foundation

struct ProductModel: Codable, Identifiable {
    var id: Int
    var title: String
    var price: Int
    var description: String
    var images: [String]
    var creationAt: String
    var updatedAt: String
    var category: CategoryModel
}
