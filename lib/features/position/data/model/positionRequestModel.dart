import 'dart:convert';

import '../../domain/entity/positionRequest_parmars.dart';

class PositionRequestModel {
  int inputType;
  String inputValue;
  String dob;
  String source;
  String tokenId;
  String iv;
  PositionData data;

  PositionRequestModel({
    required this.inputType,
    required this.inputValue,
    required this.dob,
    required this.source,
    required this.tokenId,
    required this.iv,
    required this.data,
  });

  factory PositionRequestModel.fromRawJson(String str) => PositionRequestModel.fromJson(json.decode(str));

  factory PositionRequestModel.fromEntity(PositionRequestParmas p) {
    return PositionRequestModel(
      inputType: p.inputType,
      inputValue: p.inputValue,
      dob: p.dob,
      source: p.source,
      tokenId: p.tokenId,
      iv: p.iv,
      data: PositionData(
         clientId: p.data.clientId,
        source: p.data.source,
        interop_flag: p.data.interop_flag,
        bankAccountSettlementType: p.data.bankAccountSettlementType,
      ),
    );
  }

  String toRawJson() => json.encode(toJson());

  factory PositionRequestModel.fromJson(Map<String, dynamic> json) => PositionRequestModel(
    inputType: json["inputType"],
    inputValue: json["inputValue"],
    dob: json["dob"],
    source: json["source"],
    tokenId: json["token_id"],
    iv: json["iv"],
    data: PositionData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "inputType": inputType,
    "inputValue": inputValue,
    "dob": dob,
    "source": source,
    "token_id": tokenId,
    "iv": iv,
    "data": data.toJson(),
  };
}

class PositionData {
  String source;
  String interop_flag;
  String clientId;
  String bankAccountSettlementType;

  PositionData({
    required this.source,
    required this.interop_flag,
    required this.clientId,
    required this.bankAccountSettlementType,
  });

  factory PositionData.fromJson(Map<String, dynamic> json) => PositionData(
    source: json["source"],
    interop_flag: json["interop_flag"],
    clientId: json["client_id"],
    bankAccountSettlementType: json["bankAccountSettlementType"],
  );

  Map<String, dynamic> toJson() => {
    "source": source,
    "interop_flag": interop_flag,
    "client_id": clientId,
    "bankAccountSettlementType": bankAccountSettlementType,
  };
}
