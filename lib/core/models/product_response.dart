class ProductResponse {
  final String? id;
  final String? title;
  final String? description;
  final String? price;
  final String? image;
  final String? category;
  final Rating? rating;
  final bool? isFavorite;

  ProductResponse(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.image,
      this.category,
      this.rating,
      this.isFavorite = false});

  ProductResponse copyWith({
    String? id,
    String? title,
    String? description,
    String? price,
    String? image,
    String? category,
    Rating? rating,
    bool? isFavorite,
  }) {
    return ProductResponse(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      image: image ?? this.image,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'image': image,
      'category': category,
      'rating': rating?.toMap(),
    };
  }

  factory ProductResponse.fromMap(Map<String, dynamic> map) {
    return ProductResponse(
      id: map['id'].toString(),
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      price: map['price']?.toString(),
      image: map['image'] != null ? map['image'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      rating: map['rating'] != null ? Rating.fromMap(map['rating']) : null,
    );
  }
}

class Rating {
  final double? rate;
  final int? count;
  Rating({this.rate, this.count});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rate': rate,
      'count': count,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      rate: map['rate'] != null ? (map['rate'] as num).toDouble() : null,
      count: map['count'] != null ? (map['count'] as num).toInt() : null,
    );
  }
}
