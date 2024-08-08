import 'package:dio/dio.dart';

Dio dioFactory(String baseUrl) => Dio(
  BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(
      milliseconds: 60000,
    ),
    receiveTimeout: const Duration(
      milliseconds: 60000,
    ),
    contentType: 'application/json; charset=utf-8',
  ),
);