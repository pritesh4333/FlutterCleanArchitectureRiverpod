import '../../domain/entity/HoldingResponse_parmams.dart';

class HoldingResponseModel extends HoldingResponseParams {
  HoldingResponseModel({
    required super.status,
    required super.errorCode,
    required super.message,
    required super.iv,
    required super.data,
    super.items,
  });

  /// Used for error/non-success responses where there's no encrypted
  /// payload to decrypt.
  factory HoldingResponseModel.fromJson(Map<String, dynamic> json) {
    return HoldingResponseModel(
      status: json['status'] as String? ?? '',
      errorCode: json['error_code'] as String? ?? '',
      message: json['message'] as String? ?? '',
      iv: json['iv'] as String? ?? '',
      data: json['data']?.toString() ?? '',
    );
  }
  // user for success responses with encrypted payload
  factory HoldingResponseModel.fromDecrypted({
    required Map<String, dynamic> rawJson,
    required Map<String, dynamic> decryptedJson,
  }) {
    return HoldingResponseModel(
      status: rawJson['status'] as String? ?? '',
      errorCode: rawJson['error_code'] as String? ?? '',
      message: rawJson['message'] as String? ?? '',
      iv: rawJson['iv'] as String? ?? '',
      data: rawJson['data']?.toString() ?? '',
      items: HoldingResponseRecords.fromJson(decryptedJson),
    );
  }
  // used for error/non-success responses with encrypted payload
  static HoldingResponseParams fromRawJson(Map<String, dynamic> rawJson) {
    return HoldingResponseModel.fromJson(rawJson);
  }
}

class HoldingResponseRecords extends HoldingResponseRecordsParams {
  HoldingResponseRecords({
    required super.merchantCode,
    required super.messageSeq,
    required super.requestDateTime,
    required super.dpReferenceNo,
    required super.dpid,
    required super.dpAccount,
    required super.responseCode,
    required super.errorCode,
    required super.errorMessage,
    required super.records,
  });

  factory HoldingResponseRecords.fromJson(Map<String, dynamic> json) {
    return HoldingResponseRecords(
      merchantCode: json['merchantCode'] as String?,
      messageSeq: json['messageSeq'] as String?,
      requestDateTime: json['requestDateTime'] as String?,
      dpReferenceNo: json['dpReferenceNo'] as String?,
      dpid: json['dpid'] as String?,
      dpAccount: json['dpAccount'] as String?,
      responseCode: json['responseCode'] as String?,
      errorCode: json['errorCode'] as String?,
      errorMessage: json['errorMessage'] as String?,
      records: (json['records'] as List<dynamic>?)
          ?.map((e) => Record.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }
}