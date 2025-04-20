

class CategoryModel {
  final String categoryCode;
  final String name;

  CategoryModel({required this.categoryCode, required this.name});

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
    );
  }
}
