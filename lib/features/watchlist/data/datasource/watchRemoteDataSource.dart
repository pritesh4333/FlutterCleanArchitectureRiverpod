import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/security/encryption_service.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../../watchlist/data/model/WLResponseModel.dart';
import '../../../watchlist/data/model/WlRequestModel.dart';


abstract class WatchRemoteDataSource {

  Future<WLResponseModelParams> getWlDetails(WlRequestModelParams body);
}

class WatchRemoteDataSourceImpl implements WatchRemoteDataSource {
  final Dio dio;
  final EncryptionService encryptionService;
  WatchRemoteDataSourceImpl(this.dio, this.encryptionService);


  @override
  Future<WLResponseModelParams> getWlDetails(WlRequestModelParams body) async {
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

    final response = await dio.post(ApiEndpoints.getWLDetails, data: payload);
    // Pull the same requestId your interceptor generated for this call
    final requestId = response.requestOptions.extra['requestId'] ?? 'UNKNOWN';
    final rawJson = response.data as Map<String, dynamic>;

    final status = rawJson['status'] as String? ?? '';
    if (status.toLowerCase().trim() != 'success') {
      return WLResponseModelParams.fromRawJson(rawJson);
    }

    // Decrypt the "data" field using the SAME aes key used to encrypt the
    // request (body.iv) and the iv the SERVER sent back this time
    // (rawJson['iv'] — different from ivBase64 above, which was for the request).
    final decryptedJsonString = encryptionService.decrypt(
      rawJson['data'] as String,
      rawJson['iv'] as String,
      body.iv,
    );
    print('[$requestId] 🔓 Decrypted Response: $decryptedJsonString');

    final decryptedList = jsonDecode(decryptedJsonString) as List<dynamic>;

    return WLResponseModelParams.fromDecrypted(
      rawJson: rawJson,
      decryptedList: decryptedList,
    );
  }
}