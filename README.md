### README for ShoppingCartApp

---

## **ShoppingCartApp**

This repository demonstrates a comprehensive **Shopping Cart** application built in **Swift**, utilizing **SwiftUI**, **Combine**, and the **MVVM architecture**. The app includes dynamic product management, real-time tax calculations, error handling, and robust unit testing.

---

## **Features**

1. **Product Management**:

   * Add products to the shopping cart.
   * Automatically update product quantities for duplicates.
   * Remove products or adjust their quantities dynamically.

2. **Tax Calculation**:

   * Calculates a tax of **12.5%** on the cart subtotal.
   * Provides a clear summary of subtotal, tax, and total payable amounts.

3. **Networking**:

   * Fetches product details dynamically from a remote API.
   * Handles network errors, invalid URLs, and JSON decoding gracefully.

4. **Error Handling**:

   * Displays user-friendly error messages for invalid inputs or network issues.

5. **Testing**:

   * Comprehensive unit tests for all core functionalities including product addition, tax calculations, and API interaction.

---

## **Code Structure**

### **Core Components**

1. **`ShoppingCartViewModel`**:

   * Manages the app's state including the cart items, subtotal, tax, and total.
   * Encapsulates the logic for adding products, fetching data, and recalculating totals.

2. **`ShoppingCartView`**:

   * The main SwiftUI view displaying the cart's user interface.
   * Includes forms for adding products and summaries for cart details.

3. **`Product`**:

   * A model representing a product, with properties for title and price.

4. **`CartItem`**:

   * Tracks individual product details and their quantities in the cart.

---

## **Unit Tests**

* **`ShoppingCartViewModelTests`**:

  * Validates product addition, cart recalculations, and error handling.
  * Covers scenarios such as adding duplicate products, invalid inputs, and empty carts.

* **`ShoppingCartIntegrationTests`**:

  * Tests the integration between the ViewModel and its methods.
  * Ensures cart functionality and API interaction work as expected.

---

## **Setup and Usage**

### **Prerequisites**

* **Xcode**: Version 14.0 or later.
* **Swift**: Version 5.7 or later.

### **Steps to Run**

1. Clone the repository:

   ```bash
   git clone https://github.com/your-repo/ShoppingCartApp.git
   ```
2. Open the project in Xcode:

   ```bash
   open ShoppingCartApp.xcodeproj
   ```
3. Run the app on a simulator or connected device using the play button in Xcode.

---

### **Steps to Test**

1. Select the `ShoppingCartAppTests` scheme in Xcode.
2. Run tests using:

   * The play button next to each test case.
   * Or execute all tests with `Command + U`.

---

## **How It Works**

1. **Product Management**:

   * Users input product names and quantities, which are validated and added to the cart.
   * Products are fetched from a remote API to ensure accurate details.

2. **Cart Calculations**:

   * The ViewModel computes the subtotal, applies tax, and calculates the total payable amount dynamically.

3. **Error Handling**:

   * The app displays alerts for invalid product names, quantities, or network issues.

---

## **Key Concepts Demonstrated**

* **SwiftUI**: Declarative UI for building responsive layouts.
* **Combine Framework**: Managing state and handling asynchronous operations.
* **Networking**: Fetching data from a RESTful API using `URLSession`.
* **MVVM Architecture**: Clear separation of concerns between UI and logic.
* **Unit Testing**: Ensuring functionality and robustness with XCTest.

---

## **Credits**

* **Author**: Shirish Gayakawad
* **Created On**: June 2025

---

## **Contributing**

Contributions are welcome! Feel free to:

* Fork this repository.
* Submit a pull request with proposed changes.
* Report issues or suggest enhancements.

---


