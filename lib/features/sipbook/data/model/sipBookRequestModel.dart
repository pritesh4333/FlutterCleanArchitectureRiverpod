import 'dart:convert';

import '../../domain/entity/sipBookRequest_params.dart';

class SipBookItemRequestModel {
  int inputType;
  String inputValue;
  String dob;
  String source;
  String tokenId;
  String iv;
  SipBookDataModel data;

  SipBookItemRequestModel({
    required this.inputType,
    required this.inputValue,
    required this.dob,
    required this.source,
    required this.tokenId,
    required this.iv,
    required this.data,
  });

  factory SipBookItemRequestModel.fromRawJson(String str) =>
      SipBookItemRequestModel.fromJson(json.decode(str));

  factory SipBookItemRequestModel.fromEntity(SipBookItemRequestParams p) {
    return SipBookItemRequestModel(
      inputType: p.inputType,
      inputValue: p.inputValue,
      dob: p.dob,
      source: p.source,
      tokenId: p.tokenId,
      iv: p.iv,
      data: SipBookDataModel(
        clientId: p.data.clientId,
        product: p.data.product,
      ),
    );
  }

  String toRawJson() => json.encode(toJson());

  factory SipBookItemRequestModel.fromJson(Map<String, dynamic> json) =>
      SipBookItemRequestModel(
        inputType: json["inputType"] ?? 0,
        inputValue: json["inputValue"] ?? "",
        dob: json["dob"] ?? "",
        source: json["source"] ?? "",
        tokenId: json["token_id"] ?? "",
        iv: json["iv"] ?? "",
        data: SipBookDataModel.fromJson(json["data"] ?? {}),
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

class SipBookDataModel {
  String clientId;
  String product;

  SipBookDataModel({
    required this.clientId,
    required this.product,
  });

  factory SipBookDataModel.fromJson(Map<String, dynamic> json) =>
      SipBookDataModel(
        clientId: json["client_id"] ?? "",
        product: json["product"] ?? "0",
      );

  Map<String, dynamic> toJson() => {
        "client_id": clientId,
        "product": product,
      };
}

