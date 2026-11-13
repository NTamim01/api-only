import '../../core/constants/api_constants.dart';
import '../datasource/product_remote_datasource.dart';
import '../model/paginated_products.dart';
import '../model/product.dart';

/// Single entry point the providers talk to. Local caching can be added
/// here later without touching the UI.
class ProductRepository {
  final ProductRemoteDataSource _remote;

  ProductRepository(this._remote);

  Future<PaginatedProducts> getProducts({
    int page = 0,
    int pageSize = ApiConstants.pageSize,
    String? sortBy,
    String? order,
  }) =>
      _remote.getProducts(
        limit: pageSize,
        skip: page * pageSize,
        sortBy: sortBy,
        order: order,
      );

  Future<PaginatedProducts> searchProducts(
    String query, {
    int page = 0,
    int pageSize = ApiConstants.pageSize,
  }) =>
      _remote.searchProducts(query, limit: pageSize, skip: page * pageSize);

  Future<Product> getProduct(int id) => _remote.getProductById(id);

  Future<Product> addProduct(Product product) => _remote.addProduct(product);

  Future<Product> updateProduct(Product product) =>
      _remote.updateProduct(product);

  Future<void> deleteProduct(int id) => _remote.deleteProduct(id);
}
