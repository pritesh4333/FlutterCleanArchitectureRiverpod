
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockholding/core/constants/api_endpoints.dart';

import 'DioClient.dart';

final dioProvider = Provider<Dio>((ref) {
  return DioClient.create(baseUrl: ApiEndpoints.baseUrl).dio;
});