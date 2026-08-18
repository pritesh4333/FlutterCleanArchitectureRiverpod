import '../../domain/entities/authenticate_result.dart';

class AuthenticateResponseModel extends AuthenticateResult {
  AuthenticateResponseModel({
    required super.status,
    required super.errorCode,
    required super.message,
    required super.data,
  });

  factory AuthenticateResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthenticateResponseModel(//step 9
      status: json['status'] ?? '',
      errorCode: json['error_code'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => EncryptedDataModel.fromJson(e))
          .toList(),
    );
  }
}

class EncryptedDataModel extends EncryptedData {
  EncryptedDataModel({
    required super.encryptedKey,
    required super.encryptedToken,
  });

  factory EncryptedDataModel.fromJson(Map<String, dynamic> json) {
    return EncryptedDataModel(
      encryptedKey: json['encrypted_key'] ?? '',
      encryptedToken: json['encrypted_token'] ?? '',
    );
  }
}