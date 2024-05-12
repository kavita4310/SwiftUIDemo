//
//  HomeView.swift
//  SwiftUIDemo
//
//  Created by kavita chauhan on 18/04/24.
//

import SwiftUI

struct HomeView: View {

    @State private var searchText: String = ""
    @StateObject var viewModel = ProductApi()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color.gray.edgesIgnoringSafeArea(.top)
                
                VStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search", text: $searchText)
      
                    }
                    
                    .padding()
                    .background(Color.white)
                    .frame(width: 330, height: 50)
                    .cornerRadius(25)
                    
                    NavigationStack{
                        List(viewModel.products){ product in
                            ProductListsView.init(products: product)
                        }
                    }
                }
                .padding(.top, 50)
        }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        .task {
            await viewModel.fetchProducts()
        }
    }
}


#Preview {
    HomeView()
}
