// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FavoriteItemModel {
  final int productId;
  final String name;
  final double price;
  final String photo;
  final bool? isAddedToCart;

  FavoriteItemModel(
      {required this.productId,
      required this.name,
      required this.price,
      required this.photo,
      this.isAddedToCart = false});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'name': name,
      'price': price,
      'photo': photo,
    };
  }

  factory FavoriteItemModel.fromMap(Map<String, dynamic> map) {
    return FavoriteItemModel(
      productId: map['productId'] as int,
      name: map['name'] as String,
      price: map['price'] as double,
      photo: map['photo'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteItemModel.fromJson(String source) =>
      FavoriteItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  FavoriteItemModel copyWith({
    int? productId,
    String? name,
    double? price,
    String? photo,
    bool? isAddedToCart,
  }) {
    return FavoriteItemModel(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      photo: photo ?? this.photo,
      isAddedToCart: isAddedToCart ?? this.isAddedToCart,
    );
  }
}
