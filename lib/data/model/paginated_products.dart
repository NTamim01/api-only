import 'product.dart';

class PaginatedProducts {
  final List<Product> products;
  final int total;
  final int skip;
  final int limit;

  const PaginatedProducts({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  bool get hasMore => skip + products.length < total;

  factory PaginatedProducts.fromJson(Map<String, dynamic> json) =>
      PaginatedProducts(
        products: (json['products'] as List? ?? [])
            .whereType<Map<String, dynamic>>()
            .map(Product.fromJson)
            .toList(),
        total: (json['total'] as num?)?.toInt() ?? 0,
        skip: (json['skip'] as num?)?.toInt() ?? 0,
        limit: (json['limit'] as num?)?.toInt() ?? 0,
      );
}
