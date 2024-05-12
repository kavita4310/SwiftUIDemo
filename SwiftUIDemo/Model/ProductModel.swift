//
//  ProductModel.swift
//  SwiftUIDemo
//
//  Created by kavita chauhan on 19/04/24.
//

import Foundation

struct ProductModel: Decodable,Identifiable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: RatingData
   static var dummy:ProductModel{
        return ProductModel(id: 32, title: "This is Product", price: 43.54, description: "descriptions", category: "cloths", image: "https://fakestoreapi.com/img/71-3HjGNDUL._AC_SY879._SX._UX._SY._UY_.jpg", rating: (RatingData(rate: 43.33, count: 43)))
        
    }
}


struct RatingData:Decodable{
    let rate:Double
    let count:Int
}
