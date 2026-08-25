import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:stockholding/features/holding/domain/entity/HoldingRequest_parmars.dart';
import '../../../../core/security/encryption_service.dart';
import '../../../../core/constants/api_endpoints.dart';
import '../../domain/entity/HoldingResponse_parmams.dart';
import '../model/HoldingRequestModel.dart';
import '../model/HoldingResponseModel.dart';

abstract class HoldingRemoteDataSource {
  Future<HoldingResponseParams> getHoldingDetails(HoldingRequestModel body);
}

class HoldingRemoteDataSourceImpl implements HoldingRemoteDataSource {
  final Dio dio;
  final EncryptionService encryptionService;
  HoldingRemoteDataSourceImpl(this.dio, this.encryptionService);

  @override
  Future<HoldingResponseParams> getHoldingDetails(HoldingRequestModel body) async {

    final plainJson = json.encode(body.data!.toJson());

    final result = encryptionService.encrypt(plainJson, body.iv!);
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
    print('PAYLOAD: ${jsonEncode(payload)}');
    final response = await dio.post(ApiEndpoints.getHoldingPosition, data: payload);

    final requestId = response.requestOptions.extra['requestId'] ?? 'UNKNOWN';
    final rawJson = response.data as Map<String, dynamic>;

    final status = rawJson['status'] as String? ?? '';
    if (status.toLowerCase().trim() != 'success') {
      return HoldingResponseModel.fromRawJson(rawJson);
    }


    final decryptedJsonString = encryptionService.decrypt(
      rawJson['data'] as String,
      rawJson['iv'] as String,
      body.iv!,
    );
    print('[$requestId] 🔓 Decrypted Response: $decryptedJsonString');


    final decryptedJson = jsonDecode(decryptedJsonString) as Map<String, dynamic>;

    return HoldingResponseModel.fromDecrypted(
      rawJson: rawJson,
      decryptedJson: decryptedJson,
    );
  }
}