class CreatedOrderSucessFromApiResponse {
  final int statusCode;
  final String message;
  final CreatedOrderData data;
  CreatedOrderSucessFromApiResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'statusCode': statusCode,
      'message': message,
      'data': data.toMap(),
    };
  }

  factory CreatedOrderSucessFromApiResponse.fromMap(Map<String, dynamic> map) {
    return CreatedOrderSucessFromApiResponse(
      statusCode: map['statusCode'] as int,
      message: map['message'] as String,
      data: CreatedOrderData.fromMap(map['data'] as Map<String, dynamic>),
    );
  }
}

class CreatedOrderData {
  final CreatedOrder order;
  final String paymentUrl;
  final String paymentToken;
  CreatedOrderData({
    required this.order,
    required this.paymentUrl,
    required this.paymentToken,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'order': order.toMap(),
      'paymentUrl': paymentUrl,
      'paymentToken': paymentToken,
    };
  }

  factory CreatedOrderData.fromMap(Map<String, dynamic> map) {
    return CreatedOrderData(
      order: CreatedOrder.fromMap(map['order'] as Map<String, dynamic>),
      paymentUrl: map['paymentUrl'] as String,
      paymentToken: map['paymentToken'] as String,
    );
  }
}

class CreatedOrder {
  final String orderDate;
  final String orderStatus;
  final String paymentStatus;
  final String paymentToken;
  final String customerCode;
  final double totalAmount;
  final String orderNumber;
  CreatedOrder({
    required this.orderDate,
    required this.orderStatus,
    required this.paymentStatus,
    required this.paymentToken,
    required this.customerCode,
    required this.totalAmount,
    required this.orderNumber,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'orderDate': orderDate,
      'orderStatus': orderStatus,
      'paymentStatus': paymentStatus,
      'paymentToken': paymentToken,
      'customerCode': customerCode,
      'totalAmount': totalAmount,
      'orderNumber': orderNumber,
    };
  }

  factory CreatedOrder.fromMap(Map<String, dynamic> map) {
    return CreatedOrder(
      orderDate: map['orderDate'] as String,
      orderStatus: map['orderStatus'] as String,
      paymentStatus: map['paymentStatus'] as String,
      paymentToken: map['paymentToken'] as String,
      customerCode: map['customerCode'] as String,
      totalAmount: map['totalAmount'] as double,
      orderNumber: map['orderNumber'] as String,
    );
  }
}
