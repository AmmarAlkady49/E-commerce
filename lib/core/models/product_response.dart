class ProductResponse {
  final String? id;
  final String? title;
  final String? description;
  final String? price;
  final List<String>? images;
  final String? creationAt;
  final String? updatedAt;
  final Category? category;
  final bool? isFavorite;

  ProductResponse({
    this.id,
    this.title,
    this.description,
    this.price,
    this.images,
    this.creationAt,
    this.updatedAt,
    this.category,
    this.isFavorite
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'images': images,
      'creationAt': creationAt,
      'updatedAt': updatedAt,
      'category': category?.toMap(),
    };
  }

  factory ProductResponse.fromMap(Map<String, dynamic> map) {
    return ProductResponse(
      id: map['id']?.toString(),
      title: map['title']?.toString(),
      description: map['description']?.toString(),
      price: map['price']?.toString(),
      images: map['images'] != null
          ? List<String>.from(
              (map['images'] as List).map((item) => item.toString()))
          : null,
      creationAt: map['creationAt']?.toString(),
      updatedAt: map['updatedAt']?.toString(),
      category: map['category'] != null
          ? Category.fromMap(map['category'] as Map<String, dynamic>)
          : null,
    );
  }

  ProductResponse copyWith({
    String? id,
    String? title,
    String? description,
    String? price,
    List<String>? images,
    String? creationAt,
    String? updatedAt,
    Category? category,
    bool? isFavorite,
  }) {
    return ProductResponse(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      images: images ?? this.images,
      creationAt: creationAt ?? this.creationAt,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class Category {
  final String? id;
  final String? name;
  final String? image;
  final String? creationAt;
  final String? updatedAt;

  Category({this.id, this.name, this.image, this.creationAt, this.updatedAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'creationAt': creationAt,
      'updatedAt': updatedAt,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id']?.toString(),
      name: map['name']?.toString(),
      image: map['image']?.toString(),
      creationAt: map['creationAt']?.toString(),
      updatedAt: map['updatedAt']?.toString(),
    );
  }
}
