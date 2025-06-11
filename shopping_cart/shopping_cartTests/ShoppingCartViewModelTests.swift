//
//  shopping_cartTests.swift
//  shopping_cartTests
//
//  Created by shirish gayakawad on 11/06/25.
//

import XCTest
@testable import shopping_cart

final class ShoppingCartViewModelTests: XCTestCase {
    
    var viewModel: ShoppingCartViewModel!
    
    override func setUp() {
        super.setUp()
        print("Setting up test case...")
        viewModel = ShoppingCartViewModel()
    }
    
    override func tearDown() {
        print("Tearing down test case...")
        viewModel = nil
        super.tearDown()
    }
    
    func testAddValidProduct() async {
        print("Running \(#function)...")
        await viewModel.addProduct(productName: "cornflakes", quantity: 1)
        print("Cart items after adding a valid product:", viewModel.cartItems)
        
        XCTAssertEqual(viewModel.cartItems.count, 1, "Cart should contain 1 item.")
        XCTAssertEqual(viewModel.cartItems.first?.product.title, "Corn Flakes", "Product title mismatch.")
        XCTAssertEqual(viewModel.cartItems.first?.quantity, 1, "Product quantity mismatch.")
    }
    
    func testAddMultipleProducts() async {
        print("Running \(#function)...")
        await viewModel.addProduct(productName: "cornflakes", quantity: 2)
        await viewModel.addProduct(productName: "weetabix", quantity: 1)
        print("Cart items after adding multiple products:", viewModel.cartItems)
        
        XCTAssertEqual(viewModel.cartItems.count, 2, "Cart should contain 2 items.")
        
        let cornflakes = viewModel.cartItems.first(where: { $0.product.title.lowercased() == "corn flakes" })
        let weetabix = viewModel.cartItems.first(where: { $0.product.title.lowercased() == "weetabix" })
        
        XCTAssertEqual(cornflakes?.quantity, 2, "Cornflakes quantity mismatch.")
        XCTAssertEqual(weetabix?.quantity, 1, "Weetabix quantity mismatch.")
    }
    
    func testInvalidProductName() async {
        print("Running \(#function)...")
        await viewModel.addProduct(productName: "", quantity: 1)
        print("Error state after adding an invalid product name:", viewModel.isShowingError, viewModel.errorMessage)
        
        XCTAssertEqual(viewModel.cartItems.count, 0, "Cart should remain empty.")
        XCTAssertTrue(viewModel.isShowingError, "Error flag should be true.")
        XCTAssertEqual(viewModel.errorMessage, "Invalid product name or quantity.", "Error message mismatch.")
    }
    
    func testFetchProduct() async throws {
        print("Running \(#function)...")
        let product = try await viewModel.fetchProduct(productName: "cornflakes")
        print("Fetched product:", product)
        
        XCTAssertEqual(product.title, "Corn Flakes", "Product title mismatch.")
        XCTAssertEqual(product.price, 2.52, "Product price mismatch.")
    }
    
    func testRecalculateCartWithEmptyCart() {
        print("Running \(#function)...")
        XCTAssertEqual(viewModel.cartItems.count, 0, "Cart should initially be empty.")
        
        viewModel.recalculateCart()
        print("Cart state after recalculation:", viewModel.subtotal, viewModel.tax, viewModel.total)
        
        XCTAssertEqual(viewModel.subtotal, 0.0, "Subtotal should be 0 for an empty cart.")
        XCTAssertEqual(viewModel.tax, 0.0, "Tax should be 0 for an empty cart.")
        XCTAssertEqual(viewModel.total, 0.0, "Total should be 0 for an empty cart.")
    }
    
    func testRecalculateCartWithMultipleItems() {
        print("Running \(#function)...")
        let product1 = Product(title: "Corn Flakes", price: 2.52)
        let product2 = Product(title: "Weetabix", price: 9.98)
        
        viewModel.cartItems = [
            CartItem(product: product1, quantity: 2),
            CartItem(product: product2, quantity: 1)
        ]
        
        viewModel.recalculateCart()
        print("Cart state after recalculation with multiple items:", viewModel.subtotal, viewModel.tax, viewModel.total)
        
        XCTAssertEqual(viewModel.subtotal, 15.02, accuracy: 0.01, "Subtotal mismatch.")
        XCTAssertEqual(viewModel.tax, 1.88, accuracy: 0.01, "Tax mismatch.")
        XCTAssertEqual(viewModel.total, 16.90, accuracy: 0.01, "Total mismatch.")
    }
    
    func testZeroOrNegativeQuantity() async {
        print("Running \(#function)...")
        await viewModel.addProduct(productName: "cornflakes", quantity: 0)
        print("Error state after adding product with zero/negative quantity:", viewModel.isShowingError, viewModel.errorMessage)
        
        XCTAssertEqual(viewModel.cartItems.count, 0, "Cart should remain empty.")
        XCTAssertTrue(viewModel.isShowingError, "Error flag should be true.")
        XCTAssertEqual(viewModel.errorMessage, "Invalid product name or quantity.", "Error message mismatch.")
    }
}
