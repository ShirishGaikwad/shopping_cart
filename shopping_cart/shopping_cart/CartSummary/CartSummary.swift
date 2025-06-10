//  CartSummary.swift
//  shopping_cart
//  Created by shirish gayakawad on 01/06/25.

import Foundation
struct CartSummary {
    let products: [Product: Int] // Dictionary with Product as the key and quantity as the value
    let subtotal: Double
    let totalTax: Double
    let totalPayable: Double
}
