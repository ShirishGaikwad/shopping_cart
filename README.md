
### README for ShoppingCartApp

---

## **ShoppingCartApp**

This project demonstrates a complete shopping cart functionality in **Swift**, leveraging core programming principles and patterns like MVVM, Unit Testing, and Network Communication. The application handles adding/removing products, tax calculation, and provides extensive unit testing for its components.

---

## **Features**

1. **Product Management**:

   * Add products to the shopping cart.
   * Handle duplicate products by updating their quantity.
   * Remove products or adjust their quantities dynamically.

2. **Tax Calculation**:

   * Automatically calculates a tax of 12.5% on the cart subtotal.

3. **Networking**:

   * Fetches product details dynamically from a remote API.
   * Handles errors like invalid URLs, server issues, and decoding problems gracefully.

4. **Testing**:

   * Includes extensive **Unit Tests** for core functionalities (e.g., tax calculation, API communication, and cart operations).

---

## **Code Structure**

### **Core Components**

1. **`ProductApiClient`**: Handles API communication for fetching product details.
2. **`ShoppingCart`**: Manages the cart state, including products, their quantities, and total cost calculations.
3. **`Tax`**: Contains the logic for applying taxes on monetary values.
4. **`ProductClientError`**: Enumerates possible error cases like network failure or invalid quantity.
5. **`MockURLProtocol`**: Mocks network responses for unit testing API client functions.

---

### **Unit Tests**

* **`ProductApiClientTests`**: Validates API communication, including successful responses, malformed JSON handling, and server errors.
* **`ShoppingCartTests`**: Tests for core shopping cart operations like adding products, calculating totals, and handling invalid inputs.
* **`TaxTests`**: Ensures correctness of tax calculation logic for various cases, including edge cases like negative or large amounts.

---

## **Setup and Usage**

### **Prerequisites**

* **Xcode**: Version 12.0 or later.
* **Swift**: Version 5.3 or later.

### **Steps to Run**

1. Clone the repository:

   ```bash
   git clone https://github.com/your-repo/ShoppingCartApp.git
   ```
2. Open the project in Xcode:

   ```bash
   open ShoppingCartApp.xcodeproj
   ```
3. Run the app on a simulator or device using the play button in Xcode.

---

### **Steps to Test**

1. Select the `ShoppingCartAppTests` scheme in Xcode.
2. Run tests using:

   * The play button next to each test case.
   * Or run all tests using `Command + U`.

---

## **How It Works**

1. **Product API Interaction**:

   * The `ProductApiClient` fetches product details from a mock API.
   * The results are parsed into `Product` objects, which are added to the cart.

2. **Cart State Management**:

   * The `ShoppingCart` class tracks products, their quantities, and prices.
   * Tax is dynamically applied using the `Tax` class.

3. **Error Handling**:

   * Network issues, invalid inputs, or malformed responses are gracefully handled using custom error types like `ProductClientError`.

---

## **Key Concepts Demonstrated**

* **Networking**: Using `URLSession` to interact with APIs.
* **Unit Testing**: Writing robust tests with XCTest.
* **Error Handling**: Using Swift’s `Error` protocol.
* **Encapsulation**: Abstracting logic into reusable components.
* **Mocking**: Creating mock objects for testing network-dependent components.

---

## **Credits**

* **Author**: Shirish Gayakawad
* **Date Created**: June 2025
* **Additional Repository**:[Shopping Cart Alternative Solution](https://github.com/ShirishGaikwad/shopping_cart.git)

---

Feel free to contribute, report issues, or suggest enhancements!
