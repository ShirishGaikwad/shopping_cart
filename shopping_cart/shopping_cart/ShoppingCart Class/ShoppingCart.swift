//  ShoppingCart.swift
//  shopping_cart
//  Created by shirish gayakawad on 01/06/25.
import Foundation
import Combine
extension Double {
    func roundedToTwoDecimalPlaces() -> Double {
        return (self * 100).rounded() / 100
    }
}

final class ShoppingCartViewModel: ObservableObject {
    @Published var cartItems: [CartItem] = []
    @Published var product: Product?

    @Published var subtotal: Double = 0.0
    @Published var tax: Double = 0.0
    @Published var total: Double = 0.0
    @Published var isShowingError = false
    @Published var errorMessage: String?
    
    private let taxRate = 0.125
    private let apiBaseURL = "https://equalexperts.github.io/backend-take-home-test-data"
    
    func addProduct(productName: String, quantity: Int) async {
        guard !productName.isEmpty, quantity > 0 else {
            showError(message: "Invalid product name or quantity.")
            return
        }

        do {
            let product = try await fetchProduct(productName: productName)

            await MainActor.run {
                if let existingItemIndex = cartItems.firstIndex(where: { $0.product.title.lowercased() == product.title.lowercased() }) {
                    // Update quantity if product already exists
                    cartItems[existingItemIndex].quantity += quantity
                } else {
                    // Add new product to cart
                    cartItems.append(CartItem(product: product, quantity: quantity))
                }
                recalculateCart()
            }
        } catch {
            showError(message: "An error occurred: \(error.localizedDescription)")
        }
    }


    



    func fetchProduct(productName: String) async throws -> Product {
        let baseUri = "https://equalexperts.github.io/backend-take-home-test-data/%@.json"

        guard let url = URL(string: String(format: baseUri, productName)) else {
            throw ShoppingCartError.invalidUrl
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw ShoppingCartError.serverError(statusCode: httpResponse.statusCode)
        }

        // Decode JSON into a Product
        do {
            let product = try JSONDecoder().decode(Product.self, from: data)
            return product
        } catch {
            throw ShoppingCartError.decodingError
        }
    }
//
//    private func recalculateCart() -> (subtotal: Double, totalTax: Double, totalPayable: Double) {
//        let subtotal = cartItems.reduce(0.0) { $0 + ($1.product.price * Double($1.quantity)) }
//        let taxRate = 12.5
//        let tax = subtotal > 0 ? (subtotal * taxRate / 100) : 0.0
//        let total = subtotal + tax
//        
//        // Ensure valid values
//        return (
//            subtotal: Double(round(100 * subtotal) / 100),
//            totalTax: Double(round(100 * tax) / 100),
//            totalPayable: Double(round(100 * total) / 100)
//        )
//    }
    internal func recalculateCart() {
        // Calculate subtotal
        subtotal = cartItems.reduce(0.0) { $0 + ($1.product.price * Double($1.quantity)) }
        
        // Calculate tax (12.5%)
        tax = (subtotal * taxRate).roundedToTwoDecimalPlaces()
        
        // Calculate total payable
        total = (subtotal + tax).roundedToTwoDecimalPlaces()
    }

//    private func roundToTwoDecimalPlaces(_ value: Double) -> Double {
//        return (value * 100).rounded() / 100
//    }

    private func showError(message: String) {
        errorMessage = message
        isShowingError = true
    }
}
