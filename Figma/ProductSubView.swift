//
//  ProductSubView.swift
//  Figma
//
//  Created by weirong he on 1/16/22.
//

import SwiftUI

struct ProductSubView: View {
    var product: Product

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // image
                AsyncImage(url: URL(string: product.image)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }.frame(width: 100, height: 100)
                
                
                VStack(alignment: .leading) {
                    // product name
                    Text(product.product_name).foregroundColor(Color.white).font(.bold(.body)()).padding(.vertical, 5)
                    // brand name
                    Text(product.brand_name).foregroundColor(Color.gray).font(.bold(.body)()).padding(.vertical, 5)
                    // date and time
                    VStack(alignment: .leading) {
                        Text(Api().convertStringToDate(strDate: product.date), style: .date).foregroundColor(Color.gray).font(.bold(.body)())
                        Text(Api().convertStringToDate(strDate: product.time), style: .time).foregroundColor(Color.gray).font(.bold(.body)())
                    }
                }.padding(.horizontal)
                Spacer()
            }

            // location
            Text("Location:").foregroundColor(Color.gray).font(.bold(.body)())
            HStack {
                Text(product.address.state).foregroundColor(Color.white).font(.bold(.body)())
                Text(product.address.city).foregroundColor(Color.white).font(.bold(.body)())
            }
            
            // description
            HStack {
                VStack(alignment: .leading) {
                    Text("Discription:").foregroundColor(Color.gray).font(.bold(.body)()).padding(.top, 5)
                    Text(product.discription).foregroundColor(Color.white).font(.bold(.body)())
                }
            }
        }.padding()
            .background(Color.black)
            .cornerRadius(10)
            .frame(width: UIScreen.main.bounds.width - 50)
        
    }
}

let temp: Product = Product(product_name: "Tesla housing", brand_name: "Tesla", address: Figma.Address(state: "Meghalaya", city: "Tura"), discription: "Its a good product", date: "2020-06-14T04:09:56.320Z", time: "2021-11-15T15:02:52.822Z", image: "https://png.pngtree.com/png-clipart/20190920/original/pngtree-chemical-glass-product-illustration-png-image_4626884.jpg")
struct ProductSubView_Previews: PreviewProvider {

    static var previews: some View {
        ProductSubView(product: temp)
    }
}
