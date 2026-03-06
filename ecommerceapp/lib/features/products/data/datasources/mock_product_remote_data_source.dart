import '../models/category_model.dart';
import '../models/product_model.dart';

/// Mock remote data source that returns hard-coded JSON-like maps.
///
/// Buyers can replace this with a real HTTP data source using
/// the `ApiClient` in `core/network/api_client.dart` and values
/// from `AppConfig`.
class MockProductRemoteDataSource {
  Future<List<CategoryModel>> fetchCategories() async {
    await Future<void>.delayed(const Duration(milliseconds: 400));

    final raw = <Map<String, dynamic>>[
      <String, dynamic>{'id': 'c1', 'name': 'Electronics', 'icon': 'devices'},
      <String, dynamic>{'id': 'c2', 'name': 'Fashion', 'icon': 'checkroom'},
      <String, dynamic>{'id': 'c3', 'name': 'Home', 'icon': 'weekend'},
      <String, dynamic>{'id': 'c4', 'name': 'Beauty', 'icon': 'brush'},
    ];

    return raw.map(CategoryModel.fromJson).toList();
  }

  Future<List<ProductModel>> fetchProducts() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));

    final raw = <Map<String, dynamic>>[
      <String, dynamic>{
        'id': 'p1',
        'name': 'Wireless Headphones',
        'description': 'Noise-cancelling over-ear headphones with 30h battery.',
        'price': 129.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Headphones+1',
          'https://via.placeholder.com/600x400?text=Headphones+2',
        ],
        'categoryId': 'c1',
        'isFeatured': true,
      },
      <String, dynamic>{
        'id': 'p2',
        'name': 'Smart Watch',
        'description': 'Track your workouts, sleep, and notifications.',
        'price': 199.50,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Watch+1',
        ],
        'categoryId': 'c1',
        'isFeatured': true,
      },
      <String, dynamic>{
        'id': 'p3',
        'name': 'Casual Sneakers',
        'description': 'Comfortable sneakers for everyday wear.',
        'price': 79.90,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Sneakers+1',
        ],
        'categoryId': 'c2',
        'isFeatured': true,
      },
      <String, dynamic>{
        'id': 'p4',
        'name': 'Coffee Maker',
        'description': 'Brew rich coffee with programmable timer.',
        'price': 59.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Coffee+Maker',
        ],
        'categoryId': 'c3',
        'isFeatured': false,
      },
      // More electronics (c1)
      <String, dynamic>{
        'id': 'p5',
        'name': 'Bluetooth Speaker',
        'description': 'Portable speaker with deep bass and 12h play time.',
        'price': 49.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Speaker+1',
        ],
        'categoryId': 'c1',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p6',
        'name': '4K Action Camera',
        'description': 'Waterproof camera for capturing your adventures.',
        'price': 159.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Action+Cam',
        ],
        'categoryId': 'c1',
        'isFeatured': true,
      },
      <String, dynamic>{
        'id': 'p7',
        'name': 'Wireless Keyboard & Mouse Combo',
        'description': 'Slim keyboard with silent mouse for your desk setup.',
        'price': 39.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Keyboard+Mouse',
        ],
        'categoryId': 'c1',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p8',
        'name': 'USB-C Hub',
        'description': '7‑in‑1 hub with HDMI, USB-A and SD card reader.',
        'price': 29.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=USB-C+Hub',
        ],
        'categoryId': 'c1',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p9',
        'name': 'Noise Cancelling Earbuds',
        'description': 'In‑ear earbuds with ANC and wireless charging case.',
        'price': 89.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Earbuds',
        ],
        'categoryId': 'c1',
        'isFeatured': true,
      },
      <String, dynamic>{
        'id': 'p10',
        'name': '27\" 4K Monitor',
        'description': 'Ultra‑sharp IPS display for work and entertainment.',
        'price': 299.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=4K+Monitor',
        ],
        'categoryId': 'c1',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p11',
        'name': 'Laptop Stand',
        'description': 'Aluminium stand that raises your laptop to eye level.',
        'price': 24.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Laptop+Stand',
        ],
        'categoryId': 'c1',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p12',
        'name': 'Gaming Mouse',
        'description': 'RGB gaming mouse with 8 programmable buttons.',
        'price': 54.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Gaming+Mouse',
        ],
        'categoryId': 'c1',
        'isFeatured': true,
      },
      <String, dynamic>{
        'id': 'p13',
        'name': 'Mechanical Keyboard',
        'description': 'Compact mechanical keyboard with hot‑swappable keys.',
        'price': 119.00,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Mech+Keyboard',
        ],
        'categoryId': 'c1',
        'isFeatured': false,
      },
      // Fashion (c2)
      <String, dynamic>{
        'id': 'p14',
        'name': 'Running Shoes',
        'description': 'Lightweight running shoes with breathable mesh.',
        'price': 89.50,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Running+Shoes',
        ],
        'categoryId': 'c2',
        'isFeatured': true,
      },
      <String, dynamic>{
        'id': 'p15',
        'name': 'Classic White Tee',
        'description': 'Soft cotton T‑shirt with relaxed fit.',
        'price': 19.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=White+Tee',
        ],
        'categoryId': 'c2',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p16',
        'name': 'Slim Fit Jeans',
        'description': 'Dark wash denim with a modern slim fit.',
        'price': 49.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Jeans',
        ],
        'categoryId': 'c2',
        'isFeatured': true,
      },
      <String, dynamic>{
        'id': 'p17',
        'name': 'Leather Jacket',
        'description': 'Timeless biker jacket in genuine leather.',
        'price': 219.00,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Leather+Jacket',
        ],
        'categoryId': 'c2',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p18',
        'name': 'Summer Dress',
        'description': 'Floral midi dress with flattering waistline.',
        'price': 69.90,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Summer+Dress',
        ],
        'categoryId': 'c2',
        'isFeatured': true,
      },
      <String, dynamic>{
        'id': 'p19',
        'name': 'Hoodie Sweater',
        'description': 'Cozy fleece hoodie with kangaroo pocket.',
        'price': 39.90,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Hoodie',
        ],
        'categoryId': 'c2',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p20',
        'name': 'Sports Leggings',
        'description': 'High‑waisted leggings with 4‑way stretch.',
        'price': 34.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Leggings',
        ],
        'categoryId': 'c2',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p21',
        'name': 'Denim Jacket',
        'description': 'Vintage‑wash denim jacket for layering.',
        'price': 79.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Denim+Jacket',
        ],
        'categoryId': 'c2',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p22',
        'name': 'Chunky Sneakers',
        'description': 'On‑trend chunky sole sneakers in white.',
        'price': 99.00,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Chunky+Sneakers',
        ],
        'categoryId': 'c2',
        'isFeatured': true,
      },
      <String, dynamic>{
        'id': 'p23',
        'name': 'Everyday Backpack',
        'description': 'Minimal backpack with padded laptop sleeve.',
        'price': 59.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Backpack',
        ],
        'categoryId': 'c2',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p24',
        'name': 'Baseball Cap',
        'description': 'Adjustable cap with embroidered logo.',
        'price': 24.50,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Cap',
        ],
        'categoryId': 'c2',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p25',
        'name': 'Wool Scarf',
        'description': 'Soft wool scarf in neutral colors.',
        'price': 29.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Scarf',
        ],
        'categoryId': 'c2',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p26',
        'name': 'Leather Belt',
        'description': 'Classic leather belt with metal buckle.',
        'price': 25.00,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Belt',
        ],
        'categoryId': 'c2',
        'isFeatured': false,
      },
      // Home (c3)
      <String, dynamic>{
        'id': 'p27',
        'name': 'Aroma Diffuser',
        'description': 'Ultrasonic diffuser with 7 ambient light colors.',
        'price': 39.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Diffuser',
        ],
        'categoryId': 'c3',
        'isFeatured': true,
      },
      <String, dynamic>{
        'id': 'p28',
        'name': 'Throw Blanket',
        'description': 'Chunky knit throw blanket for your sofa.',
        'price': 49.90,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Blanket',
        ],
        'categoryId': 'c3',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p29',
        'name': 'Ceramic Vase Set',
        'description': 'Set of 3 minimalist ceramic vases.',
        'price': 44.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Vase+Set',
        ],
        'categoryId': 'c3',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p30',
        'name': 'Wall Clock',
        'description': 'Silent wall clock with modern design.',
        'price': 34.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Wall+Clock',
        ],
        'categoryId': 'c3',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p31',
        'name': 'Desk Lamp',
        'description': 'LED desk lamp with adjustable arm and dimmer.',
        'price': 59.90,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Desk+Lamp',
        ],
        'categoryId': 'c3',
        'isFeatured': true,
      },
      <String, dynamic>{
        'id': 'p32',
        'name': 'Storage Baskets (Set of 3)',
        'description': 'Woven baskets for organizing shelves and closets.',
        'price': 39.50,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Baskets',
        ],
        'categoryId': 'c3',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p33',
        'name': 'Area Rug',
        'description': 'Soft area rug with geometric pattern.',
        'price': 129.00,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Area+Rug',
        ],
        'categoryId': 'c3',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p34',
        'name': 'Bedside Table',
        'description': 'Compact nightstand with drawer and shelf.',
        'price': 89.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Bedside+Table',
        ],
        'categoryId': 'c3',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p35',
        'name': 'Dining Chair',
        'description': 'Upholstered dining chair with wooden legs.',
        'price': 119.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Dining+Chair',
        ],
        'categoryId': 'c3',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p36',
        'name': 'Cookware Set',
        'description': 'Non‑stick cookware set with glass lids.',
        'price': 159.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Cookware+Set',
        ],
        'categoryId': 'c3',
        'isFeatured': true,
      },
      <String, dynamic>{
        'id': 'p37',
        'name': 'Knife Block Set',
        'description': 'Stainless steel knives with wooden block.',
        'price': 89.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Knife+Set',
        ],
        'categoryId': 'c3',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p38',
        'name': 'Glass Storage Jars',
        'description': 'Airtight jars for pantry organization (set of 5).',
        'price': 42.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Storage+Jars',
        ],
        'categoryId': 'c3',
        'isFeatured': false,
      },
      // Beauty (c4)
      <String, dynamic>{
        'id': 'p39',
        'name': 'Hydrating Face Cream',
        'description': 'Daily moisturizer for soft, glowing skin.',
        'price': 24.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Face+Cream',
        ],
        'categoryId': 'c4',
        'isFeatured': true,
      },
      <String, dynamic>{
        'id': 'p40',
        'name': 'Vitamin C Serum',
        'description': 'Brightening serum with 10% vitamin C.',
        'price': 29.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Vitamin+C+Serum',
        ],
        'categoryId': 'c4',
        'isFeatured': true,
      },
      <String, dynamic>{
        'id': 'p41',
        'name': 'Matte Lipstick Set',
        'description': 'Set of 4 long‑lasting matte lipsticks.',
        'price': 34.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Lipstick+Set',
        ],
        'categoryId': 'c4',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p42',
        'name': 'Eyeshadow Palette',
        'description': '18‑shade palette with warm and cool tones.',
        'price': 39.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Eyeshadow+Palette',
        ],
        'categoryId': 'c4',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p43',
        'name': 'Makeup Brush Set',
        'description': '12‑piece brush set with travel pouch.',
        'price': 27.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Brush+Set',
        ],
        'categoryId': 'c4',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p44',
        'name': 'Hair Dryer',
        'description': 'Ionic hair dryer with 3 heat settings.',
        'price': 59.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Hair+Dryer',
        ],
        'categoryId': 'c4',
        'isFeatured': true,
      },
      <String, dynamic>{
        'id': 'p45',
        'name': 'Curling Wand',
        'description': 'Ceramic curling wand for natural waves.',
        'price': 49.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Curling+Wand',
        ],
        'categoryId': 'c4',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p46',
        'name': 'Body Lotion',
        'description': 'Fast‑absorbing body lotion with shea butter.',
        'price': 19.50,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Body+Lotion',
        ],
        'categoryId': 'c4',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p47',
        'name': 'Shampoo & Conditioner Duo',
        'description': 'Sulfate‑free duo for everyday shine.',
        'price': 29.90,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Shampoo+Conditioner',
        ],
        'categoryId': 'c4',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p48',
        'name': 'Face Mask Pack',
        'description': 'Pack of 5 sheet masks for hydration and glow.',
        'price': 18.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Face+Masks',
        ],
        'categoryId': 'c4',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p49',
        'name': 'Nail Polish Collection',
        'description': '6‑color nail polish set with glossy finish.',
        'price': 22.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Nail+Polish',
        ],
        'categoryId': 'c4',
        'isFeatured': false,
      },
      <String, dynamic>{
        'id': 'p50',
        'name': 'Fragrance Mist',
        'description': 'Light body mist with floral scent.',
        'price': 17.99,
        'imageUrls': <String>[
          'https://via.placeholder.com/600x400?text=Fragrance+Mist',
        ],
        'categoryId': 'c4',
        'isFeatured': false,
      },
    ];

    // Replace placeholder images with real product-style photos from the web.
    final categoryImageMap = <String, String>{
      'c1':
          'https://images.pexels.com/photos/845434/pexels-photo-845434.jpeg', // electronics
      'c2':
          'https://images.pexels.com/photos/7940620/pexels-photo-7940620.jpeg', // fashion
      'c3':
          'https://images.pexels.com/photos/1571459/pexels-photo-1571459.jpeg', // home
      'c4':
          'https://images.pexels.com/photos/3738342/pexels-photo-3738342.jpeg', // beauty
    };

    for (final map in raw) {
      final imageUrl = categoryImageMap[map['categoryId'] as String?];
      if (imageUrl != null) {
        map['imageUrls'] = <String>[imageUrl];
      }
    }

    return raw.map(ProductModel.fromJson).toList();
  }
}

