//  Tax.swift
//  shopping_cart
//  Created by shirish gayakawad on 01/06/25.

import Foundation

struct Tax {
    let rate: Decimal = 0.125 // 12.5% tax rate
    
    func apply(to amount: Decimal) -> Decimal {
        return (amount * rate).rounded(scale: 2)
    }
}

extension Decimal {
    func rounded(scale: Int) -> Decimal {
        var result = Decimal()
        var value = self
        NSDecimalRound(&result, &value, scale, .bankers)
        return result
    }
}
