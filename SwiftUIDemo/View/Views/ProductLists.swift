//
//  ProductLists.swift
//  SwiftUIDemo
//
//  Created by kavita chauhan on 19/04/24.
//

import SwiftUI

struct ProductLists: View {
    @StateObject var viewModel = ProductApi()
    let productlist:String
    var body: some View {
        
        VStack{
            HStack{
                Text(productlist)
                    .font(.system(size: 14,weight: .heavy))
                    .padding(.vertical,6)
                    .padding(.horizontal,12)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(2)
                Spacer()
            }.padding(.horizontal)
            .padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(alignment: .top, spacing: 16){
                    ForEach(1..<10){ i in
                        GeometryReader{ proxy in
                            let scale = getScale(proxy: proxy)
                            
                            VStack(spacing: 8){
                                Image("backgroungImg")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 180)
                                    .clipped()
                                    .cornerRadius(8)
                                    .overlay(RoundedRectangle(cornerRadius: 8).stroke( Color(white: 0.4))
                                        .shadow(radius: 3)
                                    )
                                Text("Products")
                                    .font(.system(size: 16, weight: .semibold))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                            }
                            .scaleEffect(.init(width: scale, height: scale))
                            .animation(.easeInOut(duration: 1))
                            .padding(.vertical)
                            
                        }//end geometry
                        .frame(width: 125,height: 500)
                        .padding(.horizontal, 32)
                        .padding(.vertical,32)
                    }
                    Spacer()
                        .frame(width: 16)
                }
            }
            
        }
    }
    
    func getScale(proxy:GeometryProxy)-> CGFloat{
        let midPoint: CGFloat = 125
        let viewFrame = proxy.frame(in: CoordinateSpace.global)
        var scale: CGFloat = 1.0
        let deltaXAnimationThreshold:CGFloat = 125
        let diffFromCenter = abs(midPoint - viewFrame.origin.x - deltaXAnimationThreshold / 2)
        if diffFromCenter < deltaXAnimationThreshold{
            scale = 1 + (deltaXAnimationThreshold - diffFromCenter) / 500
        }
        
        return scale
    }
}

#Preview {
    ProductLists(productlist: "product")
}
