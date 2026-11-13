import 'package:dio/dio.dart';

import '../../core/constants/api_constants.dart';
import '../../services/dio_client.dart';
import '../model/paginated_products.dart';
import '../model/product.dart';

class ProductRemoteDataSource {
  final Dio _dio;

  ProductRemoteDataSource(DioClient client) : _dio = client.dio;

  Future<PaginatedProducts> getProducts({
    int limit = ApiConstants.pageSize,
    int skip = 0,
    String? sortBy,
    String? order,
  }) async {
    try {
      final res = await _dio.get(
        ApiConstants.products,
        queryParameters: {
          'limit': limit,
          'skip': skip,
          if (sortBy != null) 'sortBy': sortBy,
          if (order != null) 'order': order,
        },
      );
      return PaginatedProducts.fromJson(res.data as Map<String, dynamic>);
    } catch (e) {
      throw DioClient.mapError(e);
    }
  }

  Future<PaginatedProducts> searchProducts(
    String query, {
    int limit = ApiConstants.pageSize,
    int skip = 0,
  }) async {
    try {
      final res = await _dio.get(
        ApiConstants.productSearch,
        queryParameters: {'q': query, 'limit': limit, 'skip': skip},
      );
      return PaginatedProducts.fromJson(res.data as Map<String, dynamic>);
    } catch (e) {
      throw DioClient.mapError(e);
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      final res = await _dio.get('${ApiConstants.products}/$id');
      return Product.fromJson(res.data as Map<String, dynamic>);
    } catch (e) {
      throw DioClient.mapError(e);
    }
  }

  /// DummyJSON simulates the write and returns the new object (id 195+),
  /// but does not persist it on the server.
  Future<Product> addProduct(Product product) async {
    try {
      final res = await _dio.post(
        ApiConstants.productAdd,
        data: product.toJson(),
      );
      return Product.fromJson(res.data as Map<String, dynamic>);
    } catch (e) {
      throw DioClient.mapError(e);
    }
  }

  Future<Product> updateProduct(Product product) async {
    try {
      final res = await _dio.put(
        '${ApiConstants.products}/${product.id}',
        data: product.toJson(),
      );
      return Product.fromJson(res.data as Map<String, dynamic>);
    } catch (e) {
      throw DioClient.mapError(e);
    }
  }

  Future<void> deleteProduct(int id) async {
    try {
      await _dio.delete('${ApiConstants.products}/$id');
    } catch (e) {
      throw DioClient.mapError(e);
    }
  }
}
