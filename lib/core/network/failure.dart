// core/error/failure.dart
import 'package:dio/dio.dart';

sealed class Failure {
  final String message;
  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Connection timeout');
      case DioExceptionType.badResponse:
        return ServerFailure(e.response?.data['message'] ?? 'Server error');
      default:
        return ServerFailure('Something went wrong');
    }
  }
}

class NetworkFailure extends Failure {
  NetworkFailure() : super('No internet connection');
}