//
//  ValidateImageURL.swift
//  estore
//
//  Created by Nadia Lovely on 16/08/24.
//

import Foundation
import UIKit

func validateImageURL(imgUrl: String) -> Bool{
    if let url = URL(string: imgUrl), UIApplication.shared.canOpenURL(url) {
        return true
    } else {
        return false
    }
}
