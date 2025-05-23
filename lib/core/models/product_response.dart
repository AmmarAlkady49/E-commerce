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
  final List<Review>? reviews;
  final List<Photos>? photos;
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
      required this.reviews,
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
      'reviews': reviews?.map((review) => review.toMap()).toList(),
      'photos': photos?.map((photo) => photo.toMap()).toList(),
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
      //     map['reviews'] != null ? List<Review>.from(map['reviews']) : null,
      reviews: map['reviews'] != null
          ? List<Review>.from(
              (map['reviews'] as List).map((e) => Review.fromMap(e)))
          : [],

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
    List<Review>? reviews,
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
      reviews: reviews ?? this.reviews,
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

class Review {
  final String? name;
  final String? reviewText;
  final int? rating;
  final String? reviewDate;
  Review({this.name, this.reviewText, this.rating, this.reviewDate});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'reviewText': reviewText,
      'rating': rating,
      'reviewDate': reviewDate,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      name: map['name'] != null ? map['name'] as String : null,
      reviewText:
          map['reviewText'] != null ? map['reviewText'] as String : null,
      rating: map['rating'] != null ? map['rating'] as int : null,
      reviewDate:
          map['reviewDate'] != null ? map['reviewDate'] as String : null,
    );
  }
}
