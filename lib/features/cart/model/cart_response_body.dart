import 'package:e_commerce_graduation/features/cart/model/cart_item_model.dart';

class CartResponseBody {
  final String? id;
  final String? paymentToken;
  final String? paymentIntentId;
  final double? subAmount;
  final List<CartItemModel> items;

  CartResponseBody(
      {this.id,
      this.paymentToken,
      this.paymentIntentId,
      this.subAmount,
      required this.items});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'paymentToken': paymentToken,
      'paymentIntentId': paymentIntentId,
      'subAmount': subAmount,
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory CartResponseBody.fromMap(Map<String, dynamic> map) {
    return CartResponseBody(
      id: map['id'] != null ? map['id'] as String : null,
      paymentToken:
          map['paymentToken'] != null ? map['paymentToken'] as String : null,
      paymentIntentId: map['paymentIntentId'] != null
          ? map['paymentIntentId'] as String
          : null,
      subAmount: map['subAmount'] != null
          ? (map['subAmount'] as num).toDouble()
          : null,
      items: List<CartItemModel>.from(
        (map['items'] as List).map<CartItemModel>(
          (x) => CartItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
