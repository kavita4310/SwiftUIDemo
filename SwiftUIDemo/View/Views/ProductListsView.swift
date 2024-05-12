//
//  ProductListsView.swift
//  SwiftUIDemo
//
//  Created by kavita chauhan on 19/04/24.
//

import SwiftUI

struct ProductListsView: View {
    let products:ProductModel
    var body: some View {
       
        VStack{
            if let url = URL(string: products.image){
                AsyncImage(url: url){ image in
                    image.resizable()
                        .scaledToFill()
                    
                }placeholder: {
                    ProgressView()
                }
            }
        }
//        VStack{
//            Text(products.title)
//        }
    }
    
}

#Preview {
    ProductListsView(products: ProductModel.dummy)
}
