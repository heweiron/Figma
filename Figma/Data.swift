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
    
    func getProductGroupByName (products: [Product]) -> Dictionary<String, [Product]> {
        var groupByNameDict: [String: [Product]] = [:]
        for product in products {
            if groupByNameDict[product.product_name] != nil {
                groupByNameDict[product.product_name]!.append(product)
            } else {
                groupByNameDict[product.product_name] = [product]
            }
        }
        return groupByNameDict
    }
    
    func convertStringToDate(strDate: String) -> Date {
        var date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        date = dateFormatter.date(from: strDate)!
        return date
    }
    
    func getStates(products: [Product]) ->[String] {
        var stateArr:[String] = []
        for product in products {
            stateArr.append(product.address.state)
        }
        return Array(Set(stateArr))
    }
    
    func getCities(products: [Product]) ->[String] {
        var cityArr:[String] = []
        for product in products {
            cityArr.append(product.address.city)
        }
        return Array(Set(cityArr))
    }
}
