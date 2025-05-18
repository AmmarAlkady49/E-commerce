// ignore_for_file: public_member_api_docs, sort_constructors_first
class CustomerData {
  final String? id;
  final String? name;
  final String? email;
  final String? password;
  final String? phoneNumber;
  final String? address;
  final String? city;
  final String? country;
  final String? postalCode;
  final String? gender;
  final String? dateOfBirth;
  final String? photoUrl;

  CustomerData(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.phoneNumber,
      this.address = 'null',
      this.city = 'null',
      this.country = 'null',
      this.postalCode = 'null',
      this.gender = 'male',
      this.dateOfBirth,
      this.photoUrl = ''});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'address': address,
      'city': city,
      'country': country,
      'postalCode': postalCode,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
    };
  }

  factory CustomerData.fromMap(Map<String, dynamic> map) {
    return CustomerData(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber:
          map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      city: map['city'] != null ? map['city'] as String : null,
      country: map['country'] != null ? map['country'] as String : null,
      postalCode:
          map['postalCode'] != null ? map['postalCode'] as String : null,
      gender: map['gender'] != null ? map['gender'] as String : null,
      dateOfBirth:
          map['dateOfBirth'] != null ? map['dateOfBirth'] as String : null,
    );
  }

  CustomerData copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? phoneNumber,
    String? address,
    String? city,
    String? country,
    String? postalCode,
    String? gender,
    String? dateOfBirth,
    String? photoUrl,
  }) {
    return CustomerData(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      city: city ?? this.city,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
