//
//  ProductViewModel.swift
//  SwiftUIDemo
//
//  Created by kavita chauhan on 19/04/24.
//

import Foundation

class ProductApi:ObservableObject{
   @Published var products:[ProductModel] = []
    
    private var manager = APIManager()
    
    func fetchProducts() async{
        do{
           products = try await manager.request(url: "https://fakestoreapi.com/products")
            print("response",products)
        }catch{
            print("Error in fetch Product",error)
        }
    }
}
