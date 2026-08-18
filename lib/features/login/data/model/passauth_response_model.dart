import '../../domain/entities/passauth_result.dart';

class PassAuthResponseModel implements PassAuthResult {
  @override final String status;
  @override final String errorCode;
  @override final String message;
  @override final String iv;
  @override final String data;

  PassAuthResponseModel({
    required this.status,
    required this.errorCode,
    required this.message,
    required this.iv,
    required this.data,
  });

  factory PassAuthResponseModel.fromJson(Map<String, dynamic> json) =>
      PassAuthResponseModel(
        status: json['status'] as String? ?? '',
        errorCode: json['error_code'] as String? ?? '',
        message: json['message'] as String? ?? '',
        iv: json['iv'] as String? ?? '',
        data: json['data'] as String? ?? '',
      );

  @override
  bool get isSuccess => status.toLowerCase() == 'success';
}