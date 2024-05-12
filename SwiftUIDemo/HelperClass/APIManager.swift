//
//  APIManager.swift
//  SwiftUIDemo
//
//  Created by kavita chauhan on 19/04/24.
//

import Foundation

enum NetworkError:Error{
    case invalidUrl
    case invalidResponse
}


final class APIManager {
    
    func request<T:Decodable>(url:String)async throws->T{
        guard let url = URL(string: url) else {
            throw NetworkError.invalidUrl
        }
        let (data,response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else{
            throw NetworkError.invalidResponse
        }
        
        return try JSONDecoder().decode(T.self,from: data)
    }
    
}
