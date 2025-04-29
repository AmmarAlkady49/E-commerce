// ignore_for_file: public_member_api_docs, sort_constructors_first

class CategoryModel {
  final String categoryCode;
  final String name;
  final String? imageUrl;

  CategoryModel(
      {required this.categoryCode, required this.name, this.imageUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryCode': categoryCode,
      'name': name,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      categoryCode: map['categoryCode'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String?,

    );
  }

  CategoryModel copyWith({
    String? categoryCode,
    String? name,
    String? imageUrl,
  }) {
    return CategoryModel(
      categoryCode: categoryCode ?? this.categoryCode,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
