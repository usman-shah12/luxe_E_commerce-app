import '../models/category_model.dart';
import '../models/product_model.dart';

class DummyData {
  static List<CategoryModel> get categories => [
        CategoryModel(
          id: 'all',
          name: 'All',
          icon: '✦',
          imageUrl: 'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?w=400',
          productCount: 48,
        ),
        CategoryModel(
          id: 'fashion',
          name: 'Fashion',
          icon: '👗',
          imageUrl: 'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=400',
          productCount: 18,
        ),
        CategoryModel(
          id: 'accessories',
          name: 'Accessories',
          icon: '⌚',
          imageUrl: 'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=400',
          productCount: 12,
        ),
        CategoryModel(
          id: 'footwear',
          name: 'Footwear',
          icon: '👟',
          imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400',
          productCount: 9,
        ),
        CategoryModel(
          id: 'bags',
          name: 'Bags',
          icon: '👜',
          imageUrl: 'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=400',
          productCount: 9,
        ),
      ];

  static List<String> get bannerUrls => [
        'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=800&q=80',
        'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=800&q=80',
        'https://images.unsplash.com/photo-1469334031218-e382a71b716b?w=800&q=80',
        'https://images.unsplash.com/photo-1445205170230-053b83016050?w=800&q=80',
      ];

  static List<ProductModel> get products => [
        ProductModel(
          id: 'p001',
          name: 'Obsidian Silk Blazer',
          description:
              'Crafted from the finest Italian silk, this blazer redefines contemporary luxury. The fluid drape and precision tailoring create an effortless silhouette for the modern connoisseur.',
          price: 289.99,
          originalPrice: 420.00,
          imageUrl: 'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=500&q=80',
          images: [
            'https://images.unsplash.com/photo-1594938298603-c8148c4dae35?w=500&q=80',
            'https://images.unsplash.com/photo-1617127365659-c47fa864d8bc?w=500&q=80',
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=500&q=80',
          ],
          categoryId: 'fashion',
          rating: 4.8,
          reviewCount: 124,
          stock: 15,
          sizes: ['XS', 'S', 'M', 'L', 'XL'],
          colors: ['#1A1A1A', '#2D2D2D', '#4A3728'],
          isFeatured: true,
          isNew: true,
        ),
        ProductModel(
          id: 'p002',
          name: 'Velvet Noir Dress',
          description:
              'An evening gown that commands presence. Premium velvet with subtle sheen creates drama in every movement. The structured bodice and flowing skirt balance strength with elegance.',
          price: 349.99,
          originalPrice: 520.00,
          imageUrl: 'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=500&q=80',
          images: [
            'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?w=500&q=80',
            'https://images.unsplash.com/photo-1539109136881-3be0616acf4b?w=500&q=80',
          ],
          categoryId: 'fashion',
          rating: 4.9,
          reviewCount: 89,
          stock: 8,
          sizes: ['XS', 'S', 'M', 'L'],
          colors: ['#1A0A1E', '#2D1F3D', '#000000'],
          isFeatured: true,
        ),
        ProductModel(
          id: 'p003',
          name: 'Aurora Chronograph',
          description:
              'Swiss-made precision meets avant-garde design. The sapphire crystal face and hand-stitched leather band make this a timepiece worthy of legend.',
          price: 899.99,
          imageUrl: 'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=500&q=80',
          images: [
            'https://images.unsplash.com/photo-1523170335258-f5ed11844a49?w=500&q=80',
            'https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=500&q=80',
          ],
          categoryId: 'accessories',
          rating: 5.0,
          reviewCount: 56,
          stock: 5,
          sizes: [],
          colors: ['#C5A028', '#B5BABD', '#1A1A1A'],
          isFeatured: true,
          isNew: true,
        ),
        ProductModel(
          id: 'p004',
          name: 'Phantom Runner Pro',
          description:
              'Where athletic performance meets streetwear luxury. Full-grain leather upper with carbon fiber reinforcement for the discerning athlete.',
          price: 229.99,
          originalPrice: 310.00,
          imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500&q=80',
          images: [
            'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=500&q=80',
            'https://images.unsplash.com/photo-1584735175315-9d5df23be058?w=500&q=80',
          ],
          categoryId: 'footwear',
          rating: 4.7,
          reviewCount: 213,
          stock: 22,
          sizes: ['40', '41', '42', '43', '44', '45'],
          colors: ['#FFFFFF', '#1A1A1A', '#C5A028'],
          isFeatured: true,
        ),
        ProductModel(
          id: 'p005',
          name: 'Maison Tote Luxe',
          description:
              'Full-grain Italian leather tote with gold hardware. Spacious yet structured, this bag adapts from boardroom to weekend with effortless elegance.',
          price: 459.99,
          imageUrl: 'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=500&q=80',
          images: [
            'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?w=500&q=80',
            'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=500&q=80',
          ],
          categoryId: 'bags',
          rating: 4.6,
          reviewCount: 78,
          stock: 11,
          sizes: [],
          colors: ['#8B6914', '#1A1A1A', '#C4A882'],
          isFeatured: true,
          isNew: true,
        ),
        ProductModel(
          id: 'p006',
          name: 'Celestial Silk Blouse',
          description:
              'Hand-finished silk with a subtle iridescent sheen. Effortlessly transitions from day to evening with its versatile silhouette.',
          price: 189.99,
          originalPrice: 260.00,
          imageUrl: 'https://images.unsplash.com/photo-1564584217132-2271feaeb3c5?w=500&q=80',
          images: [
            'https://images.unsplash.com/photo-1564584217132-2271feaeb3c5?w=500&q=80',
          ],
          categoryId: 'fashion',
          rating: 4.5,
          reviewCount: 44,
          stock: 18,
          sizes: ['XS', 'S', 'M', 'L', 'XL', 'XXL'],
          colors: ['#E8D5B7', '#C4A8D4', '#B8C4D4'],
        ),
        ProductModel(
          id: 'p007',
          name: 'Onyx Statement Ring',
          description:
              'Sculpted from sterling silver with a large faceted black onyx center stone. Bold, architectural, unforgettable.',
          price: 149.99,
          imageUrl: 'https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=500&q=80',
          images: [
            'https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=500&q=80',
          ],
          categoryId: 'accessories',
          rating: 4.8,
          reviewCount: 33,
          stock: 25,
          sizes: ['6', '7', '8', '9'],
          colors: ['#1A1A1A', '#C5A028'],
          isNew: true,
        ),
        ProductModel(
          id: 'p008',
          name: 'Heritage Derby Shoes',
          description:
              'Goodyear-welted construction meets modern aesthetics. Full-brogue detailing on hand-polished calfskin leather.',
          price: 319.99,
          originalPrice: 420.00,
          imageUrl: 'https://images.unsplash.com/photo-1449505278894-297fdb3edbc1?w=500&q=80',
          images: [
            'https://images.unsplash.com/photo-1449505278894-297fdb3edbc1?w=500&q=80',
          ],
          categoryId: 'footwear',
          rating: 4.9,
          reviewCount: 67,
          stock: 7,
          sizes: ['40', '41', '42', '43', '44', '45'],
          colors: ['#5C3D2E', '#1A1A1A'],
        ),
      ];

  static List<Map<String, String>> get onboardingData => [
        {
          'title': 'Curated\nLuxury',
          'subtitle': 'Discover handpicked premium pieces from the world\'s finest artisans and designers.',
          'image': 'https://images.unsplash.com/photo-1483985988355-763728e1935b?w=600&q=80',
        },
        {
          'title': 'Seamless\nExperience',
          'subtitle': 'Shop with confidence. Easy returns, secure checkout, and white-glove customer service.',
          'image': 'https://images.unsplash.com/photo-1441984904996-e0b6ba687e04?w=600&q=80',
        },
        {
          'title': 'Your Style,\nElevated',
          'subtitle': 'Personalized recommendations that understand your unique aesthetic and lifestyle.',
          'image': 'https://images.unsplash.com/photo-1469334031218-e382a71b716b?w=600&q=80',
        },
      ];
}
