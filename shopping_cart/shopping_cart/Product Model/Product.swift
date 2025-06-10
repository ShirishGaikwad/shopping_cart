//  Product.swift
//  shopping_cart
//
//  Created by shirish gayakawad on 01/06/25.

import Foundation

struct Product: Codable, Hashable {
    let title: String
    let price: Double

    // Custom equality logic (optional, can rely on synthesized implementation)
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.title == rhs.title && lhs.price == rhs.price
    }

    // Custom hash logic (optional, can rely on synthesized implementation)
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(price)
    }
}
