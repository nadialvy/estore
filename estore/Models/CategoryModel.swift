//
//  CategoriesModel.swift
//  estore
//
//  Created by Nadia Lovely on 13/08/24.
//

import Foundation

struct CategoryModel:Codable, Identifiable {
    var id: Int
    var name: String
    var image: String
}
