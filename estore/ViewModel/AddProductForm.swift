//
//  AddProductValidator.swift
//  estore
//
//  Created by Nadia Lovely on 17/08/24.
//

import Foundation
import FormValidator

class AddProductForm: ObservableObject {
    @Published var manager = FormManager(validationType: .immediate)
    
    @FormField(validator: NonEmptyValidator(message: "Field is required"))
    var title: String = ""
    
    @FormField(validator: NonEmptyValidator(message: "Field is required"))
    var price: String = ""
    
    @FormField(validator: NonEmptyValidator(message: "Field is required"))
    var description: String = ""
    
    @FormField(validator: NonEmptyValidator(message: "Field is required"))
    var imageUrls: String = ""
    
    //    var images: [String] {
    //        return imageUrls.split(separator: ",").map { singleImg in
    //            let trimmedUrl = singleImg.trimmingCharacters(in: .whitespaces)
    //            if let validUrl = URL(string: trimmedUrl)?.absoluteString {
    //                return validUrl
    //            } else {
    //                return ""
    //            }
    //        }.filter { !$0.isEmpty }
    //    }
    
    var images: [String] {
        let urls = imageUrls.split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
        // Wrap array di dalam array (respon dari beken) dan convert ke string
        return [urls.description]
    }
    
    lazy var titleValidation = _title.validation(manager: manager)
    lazy var priceValidation = _price.validation(manager: manager)
    lazy var descriptionValidation = _description.validation(manager: manager)
    lazy var imagesValidation = _imageUrls.validation(manager: manager)
    
}
