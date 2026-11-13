class Dimensions {
  final double width;
  final double height;
  final double depth;

  const Dimensions({this.width = 0, this.height = 0, this.depth = 0});

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        width: (json['width'] as num?)?.toDouble() ?? 0,
        height: (json['height'] as num?)?.toDouble() ?? 0,
        depth: (json['depth'] as num?)?.toDouble() ?? 0,
      );

  Map<String, dynamic> toJson() =>
      {'width': width, 'height': height, 'depth': depth};
}

class Review {
  final int rating;
  final String comment;
  final String date;
  final String reviewerName;
  final String reviewerEmail;

  const Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        rating: (json['rating'] as num?)?.toInt() ?? 0,
        comment: json['comment'] as String? ?? '',
        date: json['date'] as String? ?? '',
        reviewerName: json['reviewerName'] as String? ?? '',
        reviewerEmail: json['reviewerEmail'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'rating': rating,
        'comment': comment,
        'date': date,
        'reviewerName': reviewerName,
        'reviewerEmail': reviewerEmail,
      };
}

class Product {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String? brand;
  final String? sku;
  final double? weight;
  final Dimensions? dimensions;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final List<Review> reviews;
  final String? returnPolicy;
  final int? minimumOrderQuantity;
  final String thumbnail;
  final List<String> images;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    this.discountPercentage = 0,
    this.rating = 0,
    this.stock = 0,
    this.tags = const [],
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews = const [],
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.thumbnail = '',
    this.images = const [],
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: (json['id'] as num?)?.toInt() ?? 0,
        title: json['title'] as String? ?? '',
        description: json['description'] as String? ?? '',
        category: json['category'] as String? ?? '',
        price: (json['price'] as num?)?.toDouble() ?? 0,
        discountPercentage:
            (json['discountPercentage'] as num?)?.toDouble() ?? 0,
        rating: (json['rating'] as num?)?.toDouble() ?? 0,
        stock: (json['stock'] as num?)?.toInt() ?? 0,
        tags: (json['tags'] as List?)?.map((e) => e.toString()).toList() ??
            const [],
        brand: json['brand'] as String?,
        sku: json['sku'] as String?,
        weight: (json['weight'] as num?)?.toDouble(),
        dimensions: json['dimensions'] is Map<String, dynamic>
            ? Dimensions.fromJson(json['dimensions'] as Map<String, dynamic>)
            : null,
        warrantyInformation: json['warrantyInformation'] as String?,
        shippingInformation: json['shippingInformation'] as String?,
        availabilityStatus: json['availabilityStatus'] as String?,
        reviews: (json['reviews'] as List?)
                ?.whereType<Map<String, dynamic>>()
                .map(Review.fromJson)
                .toList() ??
            const [],
        returnPolicy: json['returnPolicy'] as String?,
        minimumOrderQuantity:
            (json['minimumOrderQuantity'] as num?)?.toInt(),
        thumbnail: json['thumbnail'] as String? ?? '',
        images: (json['images'] as List?)?.map((e) => e.toString()).toList() ??
            const [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'price': price,
        'discountPercentage': discountPercentage,
        'rating': rating,
        'stock': stock,
        'tags': tags,
        'brand': brand,
        'sku': sku,
        'weight': weight,
        'dimensions': dimensions?.toJson(),
        'warrantyInformation': warrantyInformation,
        'shippingInformation': shippingInformation,
        'availabilityStatus': availabilityStatus,
        'reviews': reviews.map((r) => r.toJson()).toList(),
        'returnPolicy': returnPolicy,
        'minimumOrderQuantity': minimumOrderQuantity,
        'thumbnail': thumbnail,
        'images': images,
      };

  Product copyWith({
    String? title,
    String? description,
    String? category,
    double? price,
    double? discountPercentage,
    double? rating,
    int? stock,
    List<String>? tags,
    String? brand,
    String? thumbnail,
    List<String>? images,
  }) =>
      Product(
        id: id,
        title: title ?? this.title,
        description: description ?? this.description,
        category: category ?? this.category,
        price: price ?? this.price,
        discountPercentage: discountPercentage ?? this.discountPercentage,
        rating: rating ?? this.rating,
        stock: stock ?? this.stock,
        tags: tags ?? this.tags,
        brand: brand ?? this.brand,
        sku: sku,
        weight: weight,
        dimensions: dimensions,
        warrantyInformation: warrantyInformation,
        shippingInformation: shippingInformation,
        availabilityStatus: availabilityStatus,
        reviews: reviews,
        returnPolicy: returnPolicy,
        minimumOrderQuantity: minimumOrderQuantity,
        thumbnail: thumbnail ?? this.thumbnail,
        images: images ?? this.images,
      );
}
