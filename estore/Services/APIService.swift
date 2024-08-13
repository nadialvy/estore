//
//  APIService.swift
//  estore
//
//  Created by Nadia Lovely on 13/08/24.
//

import Foundation
import Alamofire

class APIService{
    static let shared = APIService() // singleton, instance APIService
    
    private init(){}
    
    // Codable = Encode (code -> JSON) + Decode (JSON -> code)
    func fetchData<T: Codable>(from endpoint: String, returning type:T.Type) async throws -> T {
        guard let url = URL(string: Constant.baseUrl + endpoint) else {
            throw URLError(.badURL)
        }
        
        let data = try await withCheckedThrowingContinuation { continuation in
            AF.request(url).responseDecodable(of: T.self) { response in
                switch response.result{
                case .success(let data):
                    continuation.resume(returning: data)
                case.failure(let err):
                    continuation.resume(throwing: err)
                }
            
            }
        }
        
        return data
        
    }
    
}
