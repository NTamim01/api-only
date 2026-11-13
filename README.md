# DummyJSON Product API Service

This package contains a clean architecture data layer for consuming DummyJSON Products API.

## How to Run

1. Open this folder in VS Code or Terminal:
   ```bash
   cd F:\api_only\api_only
   ```

2. Get dependencies:
   ```bash
   dart pub get
   ```
   *(or `flutter pub get`)*

3. Run the API test script:
   ```bash
   dart run bin/run_api.dart
   ```

This will test:
- Fetching paginated products
- Searching products
- Fetching product by ID
- Simulating adding a new product
