//
//  DebounceState.swift
//  estore
//
//  Created by Nadia Lovely on 17/08/24.
//

import Foundation
import Combine

class DebounceState: ObservableObject {
    @Published var currentValue = ""
    @Published var debouncedInput = ""
        
    init(initialValue: String, delay: Double = 0.3) {
        _currentValue = Published(initialValue: initialValue)
        _debouncedInput = Published(initialValue: initialValue)
        
        $currentValue
            .debounce(for: .seconds(delay), scheduler: RunLoop.main)
            .assign(to: &$debouncedInput)
    }
}
