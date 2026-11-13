class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://dummyjson.com';
  static const String products = '/products';
  static const String productSearch = '/products/search';
  static const String productAdd = '/products/add';

  static const int pageSize = 20;
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}
