//
//  AddCategoryForm.swift
//  estore
//
//  Created by Nadia Lovely on 17/08/24.
//

import Foundation
import FormValidator

class AddCategoryForm: ObservableObject {
    @Published var manager = FormManager(validationType: .immediate)
    
    @FormField(validator: NonEmptyValidator(message: "Field is required"))
    var categoryName: String = ""
    
    @FormField(validator: NonEmptyValidator(message: "Field is required"))
    var imgUrl: String = ""
    
    lazy var categoryNameValidation = _categoryName.validation(manager: manager)
    lazy var imgUrlValidation = _imgUrl.validation(manager: manager)
    
}
