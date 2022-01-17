//
//  ContentView.swift
//  Figma
//
//  Created by weirong he on 1/14/22.
//

import SwiftUI

struct ContentView: View {
    @State var productsGroupByName : [String: [Product]] = [:]
    @State var allProducts: [Product] = []
    @State var isExpand = false
    @State var selectedProduct: String = ""
    @State var selectedState: String = ""
    @State var selectedCity: String = ""
    
    var allKeys: [String] {
            return productsGroupByName.keys.sorted().map { String($0) }
    }
    
    var body: some View {
        
        ZStack {
            
            // background color
            Color(red: 41/255, green: 41/255, blue: 41/255).ignoresSafeArea()
            
            // content
            VStack {
                // title
                HStack {
                    Text("Edvora")
                        .padding()
                        .foregroundColor(.white)
                        .font(.bold(.largeTitle)())
                    Spacer()
                }
                
                // filter
                HStack {
                    
                    Button {
                        self.isExpand.toggle()
                    } label: {
                        HStack {
                            Text("Fliters").padding().foregroundColor(Color.white)
                            Spacer()
                            Image(systemName: "chevron.down").padding().foregroundColor(Color.white)
                        }.background(Color(red: 31/255, green: 31/255, blue: 31/255)).font(.title).frame(width: UIScreen.main.bounds.width/2)
                            .cornerRadius(10)
                    }

                    Spacer()
                    // button
                    Button {
                        selectedProduct = ""
                    } label: {
                        Text("clear filter").padding(10)
                            .foregroundColor(Color.white)
                            .background(Color(red: 31/255, green: 31/255, blue: 31/255)).font(.body)
                            .cornerRadius(10)
                    }

                }.padding()
                
                // products scrollView
                ScrollView {
                    VStack {
                        // group product by product name
                        ForEach(allKeys, id: \.self) { key in
                            if key == selectedProduct || selectedProduct == "" {
                                VStack {
                                    // product name
                                    HStack {
                                        Text(key)
                                            .foregroundColor(.white)
                                            .font(.headline)
                                        Spacer()
                                    }.padding()
                                    Divider().background(Color.white)
                                    
                                    
                                    TabView {
                                        ForEach(productsGroupByName[key]!) { product in
                                            ProductSubView(product: product)
                                        }
                                    }
                                    .frame(minHeight: 350)
                                    .tabViewStyle(PageTabViewStyle())
                                }
                            }
                            
                        }
                    }
                }
                    
            }.onAppear {
                Api().getProducts { products in
                    self.allProducts = products
                    self.productsGroupByName = Api().getProductGroupByName(products: products)
                }
            }
            
            if isExpand {
                ZStack {
                    Rectangle().foregroundColor(Color.white.opacity(0.5))
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            self.isExpand = false
                        }
                    
                    VStack {
                        Text("Filters").font(.title).foregroundColor(Color.white)
                        Divider().background(Color.white)
                        Menu {
                            Picker(selection: $selectedProduct, content: {
                                ForEach(allKeys, id: \.self) { key in
                                    Text(key).tag(key)
                                }
                            }, label: {
                                Text("Products select")
                            })
                        } label: {
                            HStack {
                                Text("Products").padding().foregroundColor(Color.white)
                                Spacer()
                                Image(systemName: "chevron.down").padding().foregroundColor(Color.white)
                            }.background(Color(red: 31/255, green: 31/255, blue: 31/255)).font(.title).frame(width: UIScreen.main.bounds.width/2)
                                .cornerRadius(10)
                        }
                        
                        Menu {
                            Picker(selection: $selectedState, content: {
                                ForEach(Api().getStates(products: productsGroupByName[selectedProduct] ?? allProducts), id: \.self) { key in
                                    Text(key).tag(key)
                                }
                            }, label: {
                                Text("States select")
                            })
                        } label: {
                            HStack {
                                Text("State").padding().foregroundColor(Color.white)
                                Spacer()
                                Image(systemName: "chevron.down").padding().foregroundColor(Color.white)
                            }.background(Color(red: 31/255, green: 31/255, blue: 31/255)).font(.title).frame(width: UIScreen.main.bounds.width/2)
                                .cornerRadius(10)
                        }
                        
                        Menu {
                            Picker(selection: $selectedCity, content: {
                                ForEach(Api().getCities(products: productsGroupByName[selectedProduct]?.filter({ product in
                                    product.address.state == selectedState
                                }) ?? productsGroupByName[selectedProduct] ?? allProducts), id: \.self) { key in
                                    Text(key).tag(key)
                                }
                            }, label: {
                                Text("City select")
                            })
                        } label: {
                            HStack {
                                Text("City").padding().foregroundColor(Color.white)
                                Spacer()
                                Image(systemName: "chevron.down").padding().foregroundColor(Color.white)
                            }.background(Color(red: 31/255, green: 31/255, blue: 31/255)).font(.title).frame(width: UIScreen.main.bounds.width/2)
                                .cornerRadius(10)
                        }
                    }.padding(30)
                        .background(Color.black)
                        .cornerRadius(25)
                        .padding()
                        
                }
            }
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
