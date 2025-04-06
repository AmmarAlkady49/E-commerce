class AddressModel {
  final String id;
  final String country;
  final String city;
  final String area;
  final bool isDefault;

  AddressModel({
    required this.id,
    required this.country,
    required this.city,
    required this.area,
    this.isDefault = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'country': country,
      'city': city,
      'area': area,
      'isDefault': isDefault
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as String,
      country: map['country'] as String,
      city: map['city'] as String,
      area: map['area'] as String,
      isDefault: map['isDefault'] as bool,
    );
  }

  AddressModel copyWith({
    String? id,
    String? country,
    String? city,
    String? area,
    bool? isDefault,
  }) {
    return AddressModel(
      id: id ?? this.id,
      country: country ?? this.country,
      city: city ?? this.city,
      area: area ?? this.area,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
