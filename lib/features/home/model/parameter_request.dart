// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ParameterRequest {
  // final int? offset;
  // final int? limit;
  // ParameterRequest({this.offset = 0, this.limit = 10});

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'offset': offset,
  //     'limit': limit,
  //   };
  // }

  // factory ParameterRequest.fromMap(Map<String, dynamic> map) {
  //   return ParameterRequest(
  //     offset: map['offset'] != null ? map['offset'] as int : null,
  //     limit: map['limit'] != null ? map['limit'] as int : null,
  //   );
  // }
  final int? limit;

  ParameterRequest({this.limit = 10});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'limit': limit,
    };
  }

  factory ParameterRequest.fromMap(Map<String, dynamic> map) {
    return ParameterRequest(
      limit: map['limit'] != null ? map['limit'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ParameterRequest.fromJson(String source) =>
      ParameterRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
