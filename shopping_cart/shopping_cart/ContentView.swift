//  ContentView.swift
//  shopping_cart
//  Created by shirish gayakawad on 01/06/25.

import SwiftUI

struct ShoppingCartView: View {
    @StateObject private var viewModel = ShoppingCartViewModel()
    @State private var productName = ""
    @State private var quantity = 1

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Add Product")) {
                        TextField("Product Name", text: $productName)
                            .autocapitalization(.none)
                        Stepper("Quantity: \(quantity)", value: $quantity, in: 1...10)
                        Button("Add to Cart") {
                            Task {
                                await viewModel.addProduct(productName: productName, quantity: quantity)
                                productName = ""
                                quantity = 1
                            }
                        }
                    }

                    Section(header: Text("Cart Items")) {
                        if viewModel.cartItems.isEmpty {
                            Text("No items in the cart.")
                        } else {
                            ForEach(viewModel.cartItems) { item in
                                HStack {
                                    Text("\(item.product.title.capitalized) x \(item.quantity)")
                                    Spacer()
                                    Text("₹\(item.totalPrice, specifier: "%.2f")")
                                }
                            }
                        }
                    }

                    Section(header: Text("Cart Summary")) {
                        HStack {
                            Text("Subtotal")
                            Spacer()
                            Text("₹\(viewModel.subtotal, specifier: "%.2f")")
                        }
                        HStack {
                            Text("Tax (12.5%)")
                            Spacer()
                            Text("₹\(viewModel.tax, specifier: "%.2f")")
                        }
                        HStack {
                            Text("Total Payable")
                            Spacer()
                            Text("₹\(viewModel.total, specifier: "%.2f")")
                        }
                    }
                }
            }
            .navigationTitle("Shopping Cart")
            .alert(isPresented: $viewModel.isShowingError) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage ?? "Unknown error"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}


struct ShoppingCartView_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingCartView()
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
