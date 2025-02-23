// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:e_commerce_graduation/core/models/product_response.dart';

class AddToCartModel {
  String id;
  int quantity;
  double userPrice;
  ProductItemModel product;
  AddToCartModel({
    required this.id,
    required this.quantity,
    required this.userPrice,
    required this.product,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quantity': quantity,
      'userPrice': userPrice,
      'product': product.toMap(),
    };
  }

  factory AddToCartModel.fromMap(Map<String, dynamic> map) {
    return AddToCartModel(
      id: map['id'] as String,
      quantity: map['quantity'] as int,
      userPrice: map['userPrice'] as double,
      product: ProductItemModel.fromMap(map['product'] as Map<String, dynamic>),
    );
  }

  AddToCartModel copyWith({
    String? id,
    int? quantity,
    double? userPrice,
    ProductItemModel? product,
  }) {
    return AddToCartModel(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      userPrice: userPrice ?? this.userPrice,
      product: product ?? this.product,
    );
  }
}
