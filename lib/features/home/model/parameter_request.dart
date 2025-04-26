class ParameterRequest {
  final int pagenum;
  final int maxpagesize;
  final int pagesize;
  final String? sort;
  final String? categoryCode;
  final String? search;
  final String? subCategoryCode;
  final String? brandCode;
  final double? minPrice;
  final double? maxPrice;
  ParameterRequest({
    required this.pagenum,
    required this.maxpagesize,
    required this.pagesize,
    this.sort,
    this.categoryCode,
    this.search,
    this.subCategoryCode,
    this.brandCode,
    this.minPrice,
    this.maxPrice,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pagenum': pagenum,
      'Maxpagesize': maxpagesize,
      'pagesize': pagesize,
      'sort': sort,
      'categoryCode': categoryCode,
      'search': search,
      'subCategoryCode': subCategoryCode,
      'brandCode': brandCode,
      'minPrice': minPrice,
      'maxPrice': maxPrice
    };
  }

  factory ParameterRequest.fromMap(Map<String, dynamic> map) {
    return ParameterRequest(
      pagenum: map['pagenum'] as int,
      maxpagesize: map['Maxpagesize'] as int,
      pagesize: map['pagesize'] as int,
      sort: map['sort'] as String?,
      categoryCode: map['categoryCode'] as String?,
      search: map['search'] as String?,
      subCategoryCode: map['subCategoryCode'] as String?,
      brandCode: map['brandCode'] as String?,
      minPrice: map['minPrice'] as double?,
      maxPrice: map['maxPrice'] as double?,
    );
  }
}
