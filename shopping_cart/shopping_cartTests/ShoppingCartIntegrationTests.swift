//
//  ShoppingCartIntegrationTests.swift
//  shopping_cart
//
//  Created by shirish gayakawad on 11/06/25.
//
import XCTest
@testable import shopping_cart

final class ShoppingCartIntegrationTests: XCTestCase {
    
    var viewModel: ShoppingCartViewModel!
    
    override func setUp() {
        super.setUp()
        print("Setting up \(#function)...")
        viewModel = ShoppingCartViewModel()
    }
    
    override func tearDown() {
        print("Tearing down \(#function)...")
        viewModel = nil
        super.tearDown()
    }
    
    func testAddSingleProduct() async {
        print("Running \(#function)...")
        
        // Act
        await viewModel.addProduct(productName: "cornflakes", quantity: 2)
        print("Cart items after adding single product:", viewModel.cartItems)
        
        // Assert cart state
        XCTAssertEqual(viewModel.cartItems.count, 1, "Cart should contain 1 product.")
        
        let cornflakes = viewModel.cartItems.first(where: { $0.product.title.lowercased() == "corn flakes" })
        XCTAssertNotNil(cornflakes, "Cornflakes should exist in the cart.")
        XCTAssertEqual(cornflakes?.quantity, 2, "Cornflakes quantity should be 2.")
        
        // Assert cart calculations
        print("Subtotal:", viewModel.subtotal, "Tax:", viewModel.tax, "Total:", viewModel.total)
        XCTAssertEqual(viewModel.subtotal, 5.04, accuracy: 0.01, "Subtotal mismatch.")
        XCTAssertEqual(viewModel.tax, 0.63, accuracy: 0.01, "Tax mismatch.")
        XCTAssertEqual(viewModel.total, 5.67, accuracy: 0.01, "Total mismatch.")
    }
    
    func testAddMultipleProducts() async {
        print("Running \(#function)...")
        
        // Act
        await viewModel.addProduct(productName: "cornflakes", quantity: 2)
        await viewModel.addProduct(productName: "weetabix", quantity: 1)
        print("Cart items after adding multiple products:", viewModel.cartItems)
        
        // Assert cart state
        XCTAssertEqual(viewModel.cartItems.count, 2, "Cart should contain 2 distinct products.")
        
        let cornflakes = viewModel.cartItems.first(where: { $0.product.title.lowercased() == "corn flakes" })
        let weetabix = viewModel.cartItems.first(where: { $0.product.title.lowercased() == "weetabix" })
        
        XCTAssertNotNil(cornflakes, "Cornflakes should exist in the cart.")
        XCTAssertEqual(cornflakes?.quantity, 2, "Cornflakes quantity should be 2.")
        
        XCTAssertNotNil(weetabix, "Weetabix should exist in the cart.")
        XCTAssertEqual(weetabix?.quantity, 1, "Weetabix quantity should be 1.")
        
        // Assert cart calculations
        print("Subtotal:", viewModel.subtotal, "Tax:", viewModel.tax, "Total:", viewModel.total)
        XCTAssertEqual(viewModel.subtotal, 15.02, accuracy: 0.01, "Subtotal mismatch.")
        XCTAssertEqual(viewModel.tax, 1.88, accuracy: 0.01, "Tax mismatch.")
        XCTAssertEqual(viewModel.total, 16.90, accuracy: 0.01, "Total mismatch.")
    }
}
