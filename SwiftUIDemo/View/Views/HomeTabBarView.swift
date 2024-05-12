//
//  HomeTabBarView.swift
//  SwiftUIDemo
//
//  Created by kavita chauhan on 18/04/24.
//

import SwiftUI

struct HomeTabBarView: View {
    var body: some View {

            
            TabView{
                
                HomeView()
                    .tabItem {
                        Text("Explore")
                        Image("hom")
                    }
                MapView()
                    .tabItem {
                        Text("Map")
                        Image("noImg2")
                    }
                MyTuurView()
                    .tabItem {
                        Text("MyTuur")
                        Image("heart")
                    }
                ProfileView()
                    .tabItem {
                        Text("Profile")
                        Image("person")
                    }
            }.accentColor(.orange)
        
    }
}

