//  CartItem.swift
//  shopping_cart
//
//  Created by shirish gayakawad on 01/06/25.
import Foundation

struct CartItem: Identifiable {
    let id = UUID()
    let product: Product
    let quantity: Int
    var totalPrice: Double {
        Double(quantity) * product.price
    }
}
