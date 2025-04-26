class GetOrderModel {
  final String orderNumber;
  final String orderDate;
  final String orderStatus;
  final String paymentStatus;
  final double totalAmount;
  final List<OrderDetails> orderDetails;
  final List<Shipping> shipping;

  GetOrderModel(
      {required this.orderNumber,
      required this.orderDate,
      required this.orderStatus,
      required this.paymentStatus,
      required this.totalAmount,
      required this.orderDetails,
      required this.shipping});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderNumber': orderNumber,
      'orderDate': orderDate,
      'orderStatus': orderStatus,
      'paymentStatus': paymentStatus,
      'totalAmount': totalAmount,
      'orderDetails': orderDetails.map((x) => x.toMap()).toList(),
      'shipping': shipping.map((x) => x.toMap()).toList(),
    };
  }

  factory GetOrderModel.fromMap(Map<String, dynamic> map) {
    return GetOrderModel(
      orderNumber: map['orderNumber'] as String,
      orderDate: map['orderDate'] as String,
      orderStatus: map['orderStatus'] as String,
      paymentStatus: map['paymentStatus'] as String,
      totalAmount: (map['totalAmount'] as num).toDouble(),
      orderDetails: List<OrderDetails>.from(
        (map['orderDetails'] as List).map(
          (x) => OrderDetails.fromMap(x as Map<String, dynamic>),
        ),
      ),
      shipping: List<Shipping>.from(
        (map['shipping'] as List).map(
          (x) => Shipping.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class OrderDetails {
  final int productID;
  final String productName;
  final String mainImage;
  final int quantity;
  final double finalPrice;
  final double subTotal;
  OrderDetails({
    required this.productID,
    required this.productName,
    required this.mainImage,
    required this.quantity,
    required this.finalPrice,
    required this.subTotal,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productID': productID,
      'productName': productName,
      'mainImage': mainImage,
      'quantity': quantity,
      'finalPrice': finalPrice,
      'subTotal': subTotal,
    };
  }

  factory OrderDetails.fromMap(Map<String, dynamic> map) {
    return OrderDetails(
      productID: map['productID'] as int,
      productName: map['productName'] as String,
      mainImage: map['mainImage'] as String,
      quantity: map['quantity'] as int,
      finalPrice: (map['finalPrice'] as num).toDouble(),
      subTotal: (map['subTotal'] as num).toDouble(),
    );
  }
}

class Shipping {
  final String address;
  final String city;
  final String country;
  final String postalCode;
  final String shippingMethod;
  final String carrier;
  final String trackingNumber;
  final String shippingStatus;
  Shipping({
    required this.address,
    required this.city,
    required this.country,
    required this.postalCode,
    required this.shippingMethod,
    required this.carrier,
    required this.trackingNumber,
    required this.shippingStatus,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'city': city,
      'country': country,
      'postalCode': postalCode,
      'shippingMethod': shippingMethod,
      'carrier': carrier,
      'trackingNumber': trackingNumber,
      'shippingStatus': shippingStatus,
    };
  }

  factory Shipping.fromMap(Map<String, dynamic> map) {
    return Shipping(
      address: map['address'] as String,
      city: map['city'] as String,
      country: map['country'] as String,
      postalCode: map['postalCode'] as String,
      shippingMethod: map['shippingMethod'] as String,
      carrier: map['carrier'] as String,
      trackingNumber: map['trackingNumber'] as String,
      shippingStatus: map['shippingStatus'] as String,
    );
  }
}
