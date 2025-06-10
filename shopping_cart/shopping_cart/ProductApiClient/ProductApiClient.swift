//  ProductApiClient.swift
//  shopping_cart
//
//  Created by shirish gayakawad on 01/06/25.
import Foundation

enum ShoppingCartError: Error {
    case invalidUrl
    case serverError(statusCode: Int)
    case decodingError
}



class ProductApiClient {
    private let baseUri = "https://equalexperts.github.io/backend-take-home-test-data/%@.json"

    func fetchProduct(productName: String) async throws -> Product {
        guard let url = URL(string: String(format: baseUri, productName)) else {
            throw ShoppingCartError.invalidUrl
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw ShoppingCartError.serverError(statusCode: httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(Product.self, from: data)
        } catch {
            throw ShoppingCartError.decodingError
        }
    }
}
