//
//  ContentView.swift
//  Figma
//
//  Created by weirong he on 1/14/22.
//

import SwiftUI

struct ContentView: View {
    @State var products: [Product] = []
    
    var body: some View {
        VStack {
            // title
            HStack {
                Text("Edvora")
                .padding()
                Spacer()
            }
            // filter
            HStack {
                Text("Filter")
                Button {
                    print("cleared")
                } label: {
                    Text("clear")
                }

            }
            // products vstack
            VStack{
                ScrollView{
                    ForEach(self.products) { product in
                        Text(product.product_name)
                    }
                }
            }
                // each product
        }.onAppear {
            Api().getProducts { products in
                self.products = products
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
