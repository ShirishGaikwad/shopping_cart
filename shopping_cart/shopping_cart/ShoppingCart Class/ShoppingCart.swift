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
            // Attempt to fetch the product from the API
            let product = try await fetchProduct(productName: productName)

            //let product = try await fetchProduct(name: productName)
            print("Fetched product: \(product)")
            
            // Create a new cart item and update the cart
            let cartItem = CartItem(product: product, quantity: quantity)
            await MainActor.run {
                cartItems.append(cartItem)
                recalculateCart() // Recalculate cart totals
            }
        } catch ShoppingCartError.invalidUrl {
            showError(message: "The URL for the product is invalid.")
        } catch ShoppingCartError.serverError(let statusCode) {
            showError(message: "Server error: \(statusCode).")
        } catch ShoppingCartError.decodingError {
            showError(message: "Failed to decode the product information.")
        } catch {
            // Catch-all for any other errors
            showError(message: "An unexpected error occurred: \(error.localizedDescription).")
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
    private func recalculateCart() {
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
