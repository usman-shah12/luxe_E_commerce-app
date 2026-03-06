class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final double? originalPrice;
  final String imageUrl;
  final List<String> images;
  final String categoryId;
  final double rating;
  final int reviewCount;
  final int stock;
  final List<String> sizes;
  final List<String> colors;
  final bool isFeatured;
  final bool isNew;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.originalPrice,
    required this.imageUrl,
    required this.images,
    required this.categoryId,
    required this.rating,
    required this.reviewCount,
    required this.stock,
    required this.sizes,
    required this.colors,
    this.isFeatured = false,
    this.isNew = false,
  });

  double get discountPercent {
    if (originalPrice == null || originalPrice! <= price) return 0;
    return ((originalPrice! - price) / originalPrice! * 100).roundToDouble();
  }

  bool get hasDiscount => originalPrice != null && originalPrice! > price;

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    double? originalPrice,
    String? imageUrl,
    List<String>? images,
    String? categoryId,
    double? rating,
    int? reviewCount,
    int? stock,
    List<String>? sizes,
    List<String>? colors,
    bool? isFeatured,
    bool? isNew,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      imageUrl: imageUrl ?? this.imageUrl,
      images: images ?? this.images,
      categoryId: categoryId ?? this.categoryId,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      stock: stock ?? this.stock,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      isFeatured: isFeatured ?? this.isFeatured,
      isNew: isNew ?? this.isNew,
    );
  }
}

class CartItemModel {
  final ProductModel product;
  int quantity;
  String selectedSize;
  String selectedColor;

  CartItemModel({
    required this.product,
    required this.quantity,
    required this.selectedSize,
    required this.selectedColor,
  });

  double get totalPrice => product.price * quantity;
}
