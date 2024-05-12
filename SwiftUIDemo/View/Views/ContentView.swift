//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by kavita chauhan on 19/04/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            ScrollView{
               ProductLists(productlist: "product")
            }
        }.navigationBarTitle("Products")
       
    }
}

#Preview {
    ContentView()
}
