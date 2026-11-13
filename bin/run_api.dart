import '../lib/core/errors/app_exception.dart';
import '../lib/data/datasource/product_remote_datasource.dart';
import '../lib/data/model/product.dart';
import '../lib/data/repository/product_repository.dart';
import '../lib/services/dio_client.dart';

void main() async {
  print('====================================================');
  print('       🚀 Starting DummyJSON Product API Test       ');
  print('====================================================\n');

  final dioClient = DioClient();
  final remoteDataSource = ProductRemoteDataSource(dioClient);
  final repository = ProductRepository(remoteDataSource);

  try {
    // 1. Fetch Paginated Products
    print('📦 [Test 1] Fetching first 5 products from API...');
    final result = await repository.getProducts(pageSize: 5);
    print('✅ Success! Total products on server: ${result.total}');
    print('   Showing ${result.products.length} products:');
    for (var product in result.products) {
      print('   • [ID: ${product.id}] ${product.title} - \$${product.price} (Rating: ${product.rating} ★)');
    }
    print('');

    // 2. Search Products
    final searchQuery = 'phone';
    print('🔍 [Test 2] Searching products with query "$searchQuery"...');
    final searchResult = await repository.searchProducts(searchQuery, pageSize: 3);
    print('✅ Success! Found ${searchResult.total} matches. Showing top ${searchResult.products.length}:');
    for (var product in searchResult.products) {
      print('   • ${product.title} (\$$product.price) - Category: ${product.category}');
    }
    print('');

    // 3. Fetch Single Product
    const testId = 1;
    print('🔎 [Test 3] Fetching single product details for ID: $testId...');
    final singleProduct = await repository.getProduct(testId);
    print('✅ Success! Product: ${singleProduct.title}');
    print('   Brand: ${singleProduct.brand ?? "N/A"}');
    print('   Description: ${singleProduct.description}');
    print('   Thumbnail: ${singleProduct.thumbnail}');
    print('');

    // 4. Simulate Add Product
    print('➕ [Test 4] Simulating adding a new product...');
    final newProduct = Product(
      id: 0,
      title: 'Antigravity AI Test Phone',
      description: 'A test product created to verify POST requests.',
      category: 'smartphones',
      price: 999.99,
      discountPercentage: 10.0,
      rating: 5.0,
      stock: 50,
      tags: ['ai', 'smartphone'],
    );
    final addedProduct = await repository.addProduct(newProduct);
    print('✅ Success! Server responded with created product ID: ${addedProduct.id}');
    print('   Title: ${addedProduct.title}');
    print('   Price: \$${addedProduct.price}');
    print('');

    print('====================================================');
    print('       🎉 All API tests passed successfully!        ');
    print('====================================================');
  } on AppException catch (e) {
    print('❌ Application Error [${e.type}]: ${e.message}');
    if (e.statusCode != null) {
      print('   Status Code: ${e.statusCode}');
    }
  } catch (e, stack) {
    print('❌ Unexpected Error: $e');
    print(stack);
  }
}
