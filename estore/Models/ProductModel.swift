//
//  ProductModel.swift
//  estore
//
//  Created by Nadia Lovely on 13/08/24.
//

import Foundation

//struct ProductModel: Codable, Identifiable {
//    var id: Int
//    var title: String
//    var price: Int
//    var description: String
//    var images: [String]
//    var creationAt: String
//    var updatedAt: String
//    var category: CategoryModel
//}

struct ProductModel: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Int
    let description: String
    let images: [String]
    let creationAt: String
    let updatedAt: String
    let category: CategoryModel

    enum CodingKeys: String, CodingKey {
        case id, title, price, description, images, creationAt, updatedAt, category
    }

    init(id: Int, title: String, price: Int, description: String, images: [String], creationAt: String, updatedAt: String, category: CategoryModel) {
        self.id = id
        self.title = title
        self.price = price
        self.description = description
        self.images = images
        self.creationAt = creationAt
        self.updatedAt = updatedAt
        self.category = category
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        price = try container.decode(Int.self, forKey: .price)
        description = try container.decode(String.self, forKey: .description)
        creationAt = try container.decode(String.self, forKey: .creationAt)
        updatedAt = try container.decode(String.self, forKey: .updatedAt)
        category = try container.decode(CategoryModel.self, forKey: .category)

        // Handle nested array dari beken ketika return image URLs
        let imageStrings = try container.decode([String].self, forKey: .images)
        images = imageStrings.compactMap { str -> [String]? in
            guard let data = str.data(using: .utf8),
                  let jsonArray = try? JSONDecoder().decode([String].self, from: data) else {
                return nil
            }
            return jsonArray
        }.flatMap { $0 }
    }
}
