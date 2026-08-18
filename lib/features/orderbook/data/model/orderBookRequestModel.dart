import 'dart:convert';

import '../../domain/entity/orderBookRequest_parmars.dart';

class OrderBookItemRequestModel {
  int inputType;
  String inputValue;
  String dob;
  String source;
  String tokenId;
  String iv;
  OrderBookData data;

  OrderBookItemRequestModel({
    required this.inputType,
    required this.inputValue,
    required this.dob,
    required this.source,
    required this.tokenId,
    required this.iv,
    required this.data,
  });

  factory OrderBookItemRequestModel.fromRawJson(String str) => OrderBookItemRequestModel.fromJson(json.decode(str));

  factory OrderBookItemRequestModel.fromEntity(OrderBookItemRequestParmas p) {
    return OrderBookItemRequestModel(
      inputType: p.inputType,
      inputValue: p.inputValue,
      dob: p.dob,
      source: p.source,
      tokenId: p.tokenId,
      iv: p.iv,
      data: OrderBookData(
         clientId: p.data.clientId, source: p.data.source, sortBy: p.data.sortBy, bankAccountSettlementType: p.data.bankAccountSettlementType,
      ),
    );
  }

  String toRawJson() => json.encode(toJson());

  factory OrderBookItemRequestModel.fromJson(Map<String, dynamic> json) => OrderBookItemRequestModel(
    inputType: json["inputType"],
    inputValue: json["inputValue"],
    dob: json["dob"],
    source: json["source"],
    tokenId: json["token_id"],
    iv: json["iv"],
    data: OrderBookData.fromJson(json["data"]),
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

class OrderBookData {
  String source;
  String sortBy;
  String clientId;
  String bankAccountSettlementType;

  OrderBookData({
    required this.source,
    required this.sortBy,
    required this.clientId,
    required this.bankAccountSettlementType,
  });

  factory OrderBookData.fromJson(Map<String, dynamic> json) => OrderBookData(
    source: json["source"],
    sortBy: json["sort_by"],
    clientId: json["client_id"],
    bankAccountSettlementType: json["bankAccountSettlementType"],
  );

  Map<String, dynamic> toJson() => {
    "source": source,
    "sort_by": sortBy,
    "client_id": clientId,
    "bankAccountSettlementType": bankAccountSettlementType,
  };
}
