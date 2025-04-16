// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductItemModel {
  final String? id;
  final String? title;
  final String? description;
  final double? price;
  final String? image;
  final String? category;
  final Rating? rating;
  final bool? isFavorite;

  ProductItemModel(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.image,
      this.category,
      this.rating,
      this.isFavorite = false});

  ProductItemModel copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? image,
    String? category,
    Rating? rating,
    bool? isFavorite,
  }) {
    return ProductItemModel(
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

  factory ProductItemModel.fromMap(Map<String, dynamic> map) {
    return ProductItemModel(
      id: map['id'].toString(),
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      price: map['price'] is num
          ? (map['price'] as num).toDouble()
          : double.tryParse(map['price'].toString()),
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

class ProductResponse {
  final int? productID;
  final String? name;
  final String? description;
  final double? price;
  final String? categoryName;
  final String? subCategoryName;
  final String? brandName;
  final int? stockQuantity;
  final double? rating;
  final int? reviewCount;
  // final List<String>? reviews;
  final List<Photos> photos;
  final bool? isFavorite;

  ProductResponse(
      {required this.productID,
      required this.name,
      required this.description,
      required this.price,
      required this.categoryName,
      required this.subCategoryName,
      required this.brandName,
      required this.stockQuantity,
      required this.rating,
      required this.reviewCount,
      // required this.reviews,
      required this.photos,
      this.isFavorite = false});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productID': productID,
      'name': name,
      'description': description,
      'price': price,
      'categoryName': categoryName,
      'subCategoryName': subCategoryName,
      'brandName': brandName,
      'stockQuantity': stockQuantity,
      'rating': rating,
      'reviewCount': reviewCount,
      // 'reviews': reviews,
      'photos': photos.map((photo) => photo.toMap()).toList(),
    };
  }

  factory ProductResponse.fromMap(Map<String, dynamic> map) {
    return ProductResponse(
      productID: map['productID'] != null ? map['productID'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      price: map['price'] != null
          ? (map['price'] is int
              ? (map['price'] as int).toDouble()
              : map['price'] as double)
          : null,
      categoryName:
          map['categoryName'] != null ? map['categoryName'] as String : null,
      subCategoryName: map['subCategoryName'] != null
          ? map['subCategoryName'] as String
          : null,
      brandName: map['brandName'] != null ? map['brandName'] as String : null,
      stockQuantity:
          map['stockQuantity'] != null ? map['stockQuantity'] as int : null,
      rating: map['rating'] != null
          ? (map['rating'] is int
              ? (map['rating'] as int).toDouble()
              : map['rating'] as double)
          : null,
      reviewCount:
          map['reviewCount'] != null ? map['reviewCount'] as int : null,
      // reviews:
      //     map['reviews'] != null ? List<String>.from(map['reviews']) : null,
      photos: map['photos'] != null
          ? List<Photos>.from(
              (map['photos'] as List).map((e) => Photos.fromMap(e)))
          : [],
    );
  }

  ProductResponse copyWith({
    int? productID,
    String? name,
    String? description,
    double? price,
    String? categoryName,
    String? subCategoryName,
    String? brandName,
    int? stockQuantity,
    double? rating,
    int? reviewCount,
    List<Photos>? photos,
    bool? isFavorite,
  }) {
    return ProductResponse(
      productID: productID ?? this.productID,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      categoryName: categoryName ?? this.categoryName,
      subCategoryName: subCategoryName ?? this.subCategoryName,
      brandName: brandName ?? this.brandName,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      photos: photos ?? this.photos,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

class Photos {
  final String? imageURL;
  final int? productID;
  Photos({this.imageURL, this.productID});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageURL': imageURL,
      'productID': productID,
    };
  }

  factory Photos.fromMap(Map<String, dynamic> map) {
    return Photos(
      imageURL: map['imageURL'] != null ? map['imageURL'] as String : null,
      productID: map['productID'] != null ? map['productID'] as int : null,
    );
  }
}
