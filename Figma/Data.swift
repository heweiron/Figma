//
//  Data.swift
//  Figma
//
//  Created by weirong he on 1/14/22.
//

import Foundation

struct Product: Codable, Identifiable {
    let id = UUID()
    var product_name: String
    var brand_name: String
    var address: Address
    var discription: String
    var date: String
    var time: String
    var image: String
}

struct Address: Codable {
    var state: String = ""
    var city: String = ""
}

class Api {
    func getProducts(completion: @escaping ([Product]) -> ()) {
        guard let url = URL(string: "https://assessment-edvora.herokuapp.com/") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            let products = try! JSONDecoder().decode([Product].self, from: data!)
            DispatchQueue.main.async {
                completion(products)
            }
            
        }.resume()
    }
}
