class ShippingDto {
  final String address;
  final String city;
  final String country;
  final String postalCode;
  final String shippingMethod;
  final bool useProfileAddress;
  final bool updateProfileAddress;

  ShippingDto(
      {required this.address,
      required this.city,
      required this.country,
      required this.postalCode,
      required this.shippingMethod,
      required this.useProfileAddress,
      required this.updateProfileAddress});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'city': city,
      'country': country,
      'postalCode': postalCode,
      'shippingMethod': shippingMethod,
      'useProfileAddress': useProfileAddress,
      'updateProfileAddress': updateProfileAddress,
    };
  }

  factory ShippingDto.fromMap(Map<String, dynamic> map) {
    return ShippingDto(
      address: map['address'] as String,
      city: map['city'] as String,
      country: map['country'] as String,
      postalCode: map['postalCode'] as String,
      shippingMethod: map['shippingMethod'] as String,
      useProfileAddress: map['useProfileAddress'] as bool,
      updateProfileAddress: map['updateProfileAddress'] as bool,
    );
  }
}
