class CartItemModel {
  final int productId;
  final String name;
  final int quantity;
  final double price;
  final String photo;
  final double totalPrice;

  CartItemModel(
      {required this.productId,
      required this.name,
      required this.quantity,
      required this.price,
      required this.photo,
      required this.totalPrice});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productId': productId,
      'name': name,
      'quantity': quantity,
      'price': price,
      'photo': photo,
      'totalPrice': totalPrice,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      productId: (map['productId'] as num).toInt(),
      name: map['name'] as String,
      quantity: (map['quantity'] as num).toInt(),
      price: (map['price'] as num).toDouble(),
      photo: map['photo'] as String,
      totalPrice: (map['totalPrice'] as num).toDouble(),
    );
  }

  CartItemModel copyWith({
    int? productId,
    String? name,
    int? quantity,
    double? price,
    String? photo,
    double? totalPrice,
  }) {
    return CartItemModel(
      productId:  productId ?? this.productId,
      name:  name ?? this.name,
      quantity:  quantity ?? this.quantity,
      price:  price ?? this.price,
      photo:  photo ?? this.photo,
      totalPrice:  totalPrice ?? this.totalPrice,
    );
  }
}
