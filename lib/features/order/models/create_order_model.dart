import 'package:e_commerce_graduation/features/order/models/shipping_dto.dart';

class CreateOrderModel {
  final String cartId;
  final ShippingDto shippingDTO;

  CreateOrderModel({required this.cartId, required this.shippingDTO});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cartId': cartId,
      'shippingDTO': shippingDTO.toMap(),
    };
  }

  factory CreateOrderModel.fromMap(Map<String, dynamic> map) {
    return CreateOrderModel(
      cartId: map['cartId'] as String,
      shippingDTO:
          ShippingDto.fromMap(map['shippingDTO'] as Map<String, dynamic>),
    );
  }
}
