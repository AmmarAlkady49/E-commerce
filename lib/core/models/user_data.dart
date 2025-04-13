class UserData {
  final String uid;
  final String email;
  final String firstName;
  final String lasttName;
  final String? photoUrl;
  final String birthDate;
  final String phoneNumber;
  final String createdAt;

  UserData(
      {required this.uid,
      required this.email,
      required this.firstName,
      required this.lasttName,
      this.photoUrl = 'assets/images/home_page/face_avatar1.png',
      required this.birthDate,
      required this.phoneNumber,
      required this.createdAt});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lasttName': lasttName,
      'photoUrl': photoUrl,
      'birthDate': birthDate,
      'phoneNumber': phoneNumber,
      'createdAt': createdAt,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      uid: map['uid'] ?? "",
      email: map['email'] ?? "",
      firstName: map['firstName'] ?? "",
      lasttName: map['lasttName'] ?? "",
      photoUrl: map['photoUrl'] != null ? map['photoUrl'] as String : null,
      birthDate: map['birthDate'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
      createdAt: map['createdAt'] ?? "",
    );
  }
}


