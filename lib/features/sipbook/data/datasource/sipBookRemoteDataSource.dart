import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/security/encryption_service.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../model/sipBookRequestModel.dart';
import '../model/sipBookResponseModel.dart';

abstract class SipBookRemoteDataSource {
  Future<SipBookItemResponseModel> getSipDetails(SipBookItemRequestModel body);
}

class SipBookRemoteDataSourceImpl implements SipBookRemoteDataSource {
  final Dio dio;
  final EncryptionService encryptionService;

  SipBookRemoteDataSourceImpl(this.dio, this.encryptionService);

  @override
  Future<SipBookItemResponseModel> getSipDetails(SipBookItemRequestModel body) async {
    final plainJson = json.encode(body.data.toJson());

    final result = encryptionService.encrypt(plainJson, body.iv);
    final encryptedData = result[0];
    final ivBase64 = result[1];

    final payload = {
      'inputType': body.inputType,
      'inputValue': body.inputValue,
      'dob': body.dob,
      'source': body.source,
      'data': encryptedData,
      'iv': ivBase64,
      'token_id': body.tokenId,
    };

    final response = await dio.post(ApiEndpoints.getSipBook, data: payload);
    final requestId = response.requestOptions.extra['requestId'] ?? 'UNKNOWN';
    final rawJson = response.data as Map<String, dynamic>;

    final status = rawJson['status'] as String? ?? '';
    if (status.toLowerCase().trim() != 'success') {
      return SipBookItemResponseModel.fromRawJson(rawJson);
    }

    final decryptedJsonString = encryptionService.decrypt(
      rawJson['data'] as String,
      rawJson['iv'] as String,
      body.iv,
    );

    print('[$requestId] 🔓 Decrypted SIP Response: $decryptedJsonString');

    final decryptedList = jsonDecode(decryptedJsonString) as List<dynamic>;

    return SipBookItemResponseModel.fromDecrypted(
      rawJson: rawJson,
      decryptedList: decryptedList,
    );
  }
}

