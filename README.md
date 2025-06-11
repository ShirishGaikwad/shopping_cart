
### README for ShoppingCartApp

---

## **ShoppingCartApp**

This repository demonstrates a comprehensive **Shopping Cart** application built in **Swift**, utilizing **SwiftUI**, **Combine**, and the **MVVM architecture**. The app integrates with a Price API for dynamic product pricing, provides real-time cart state management, and implements robust unit testing.

---

## **Begin the Task**

This application is designed to fulfill the following shopping cart capabilities:

1. **Add Products to the Cart**:

   * Specify the product name and quantity.
   * Retrieve the product price dynamically from the Price API.

2. **Cart State Management**:

   * View the cart subtotal (sum of prices for all items).
   * Calculate tax payable at **12.5%** on the subtotal.
   * Compute the total payable (subtotal + tax).
   * Round all totals to **two decimal places**.

3. **Price API Integration**:

   * Fetch product prices using the Price API.
   * Handle errors such as missing product data or network issues.

---

## **Features**

1. **Dynamic Product Pricing**:

   * Integrates with the Price API to retrieve accurate prices for specified products.

2. **Stateful Cart Management**:

   * Tracks the quantity and total price for each product.
   * Provides a summary of subtotal, tax, and total payable.

3. **Error Handling**:

   * Handles invalid product names, network failures, and API errors gracefully.

4. **Testing**:

   * Comprehensive unit tests to ensure the correctness of cart operations and API integration.

---

## **Example Usage**

### **Inputs**

1. Add 1 × `cornflakes` @ 2.52 each.
2. Add another 1 × `cornflakes` @ 2.52 each.
3. Add 1 × `weetabix` @ 9.98 each.

### **Results**

* Cart contains **2 x cornflakes**.
* Cart contains **1 x weetabix**.
* **Subtotal**: 15.02
* **Tax**: 1.88
* **Total**: 16.90

---

## **Code Structure**

### **Core Components**

1. **`ShoppingCartViewModel`**:

   * Handles product addition, price retrieval, and cart state calculations.
   * Provides real-time updates for subtotal, tax, and total payable.

2. **`Product`**:

   * Represents a product with properties such as `name` and `price`.

3. **`CartItem`**:

   * Tracks individual product quantities and prices.

4. **`PriceAPIService`**:

   * Fetches product prices from the Price API.

5. **`ShoppingCartView`**:

   * SwiftUI-based interface for viewing and managing the cart.

---

## **Price API Service**

### **Service Details**

* **Base URL**: `https://equalexperts.github.io/`
* **Endpoint**: `/backend-take-home-test-data/{product}.json`

### **List of Available Products**

* cheerios
* cornflakes
* frosties
* shreddies
* weetabix

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

## **Key Concepts Demonstrated**

* **SwiftUI**: Declarative UI framework for building interactive views.
* **Combine Framework**: Managing asynchronous operations and state.
* **Networking**: Using `URLSession` to fetch product data from the Price API.
* **MVVM Architecture**: Clear separation of UI and business logic.
* **Unit Testing**: Ensuring correctness of cart operations with XCTest.

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



