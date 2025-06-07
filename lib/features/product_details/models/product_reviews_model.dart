class ProductReviewsModel {
  final String customerId;
  final String customerName;
  final int reviewId;
  final int rating;
  final String reviewText;
  final String reviewDate;

  ProductReviewsModel(
      {required this.customerId,
      required this.customerName,
      required this.reviewId,
      required this.rating,
      required this.reviewText,
      required this.reviewDate});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customerId': customerId,
      'customerName': customerName,
      'reviewId': reviewId,
      'rating': rating,
      'reviewText': reviewText,
      'reviewDate': reviewDate,
    };
  }

  factory ProductReviewsModel.fromMap(Map<String, dynamic> map) {
    return ProductReviewsModel(
      customerId: map['customerId'] as String,
      customerName: map['customerName'] as String,
      reviewId: map['reviewId'] as int,
      rating: map['rating'] as int,
      reviewText: map['reviewText'] as String,
      reviewDate: map['reviewDate'] as String,
    );
  }
}
