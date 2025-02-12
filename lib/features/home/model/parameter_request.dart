class ParameterRequest {
  final int? offset;
  final int? limit;
  ParameterRequest({this.offset = 0, this.limit = 10});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'offset': offset,
      'limit': limit,
    };
  }

  factory ParameterRequest.fromMap(Map<String, dynamic> map) {
    return ParameterRequest(
      offset: map['offset'] != null ? map['offset'] as int : null,
      limit: map['limit'] != null ? map['limit'] as int : null,
    );
  }
}
