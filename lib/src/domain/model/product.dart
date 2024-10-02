class Category {
  final int id;
  final String name;
  final String image;
  final DateTime creationAt;
  final DateTime? updateAt;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.creationAt,
    required this.updateAt,
  });

  factory Category.fromDynamic(dynamic map) => Category(
        id: map['id'],
        name: map['name'],
        image: map['image'],
        creationAt: DateTime.parse(map['creationAt']),
        updateAt:
            map['updateAt'] != null ? DateTime.parse(map['updateAt']) : null,
      );
}

class Product {
  final int id;
  final String title;
  final int price;
  final String description;
  final List<String> images;
  final DateTime creationAt;
  final DateTime? updateAt;
  final Category category;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.creationAt,
    required this.updateAt,
    required this.category,
  });

  factory Product.fromDynamic(dynamic map) {
    final categoryMap = map['category'] as Map<String, dynamic>?;
    final category = Category.fromDynamic(categoryMap);

    final imagesList = map['images'] as List<dynamic>?;
    final images = imagesList?.map((image) => image as String).toList();

    return Product(
      id: map['id'],
      title: map['title'],
      price: map['price'],
      description: map['description'],
      images: images ?? [],
      creationAt: DateTime.parse(map['creationAt']),
      updateAt:
          map['updateAt'] != null ? DateTime.parse(map['updateAt']) : null,
      category: category,
    );
  }

  static List<Product> fromDynamicList(dynamic list) {
    final result = <Product>[];

    if (list != null) {
      for (dynamic map in list) {
        result.add(Product.fromDynamic(map));
      }
    }

    return result;
  }
}
