import 'package:flutter/material.dart';

class ApiErrorModel {
  final String message;
  final String statusCode;
  final IconData iconData;

  ApiErrorModel({
    required this.message,
    required this.statusCode,
    required this.iconData,
  });
}
