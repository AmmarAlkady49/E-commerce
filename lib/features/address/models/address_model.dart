class AddressModel {
  final String id;
  final String country;
  final String city;
  final String address;
  final String postalCode;

  AddressModel({
    required this.id,
    required this.country,
    required this.city,
    required this.address,
    required this.postalCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'country': country,
      'city': city,
      'address': address,
      'postalCode': postalCode,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as String,
      country: map['country'] as String,
      city: map['city'] as String,
      address: map['address'] as String,
      postalCode: map['postalCode'] as String,
    );
  }

  AddressModel copyWith({
    String? id,
    String? country,
    String? city,
    String? address,
    String? postalCode,
  }) {
    return AddressModel(
      id: id ?? this.id,
      country: country ?? this.country,
      city: city ?? this.city,
      address: address ?? this.address,
      postalCode: postalCode ?? this.postalCode,
    );
  }
}
