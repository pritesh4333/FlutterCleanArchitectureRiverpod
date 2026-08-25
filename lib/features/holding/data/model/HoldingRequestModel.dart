import 'dart:convert';

import 'package:stockholding/features/holding/domain/entity/HoldingRequest_parmars.dart';

class HoldingRequestModel {
  int? inputType;
  String? inputValue;
  String? dob;
  String? source;
  String? tokenId;
  String? iv;
  Data? data;

  HoldingRequestModel({
    this.inputType,
    this.inputValue,
    this.dob,
    this.source,
    this.tokenId,
    this.iv,
    this.data,
  });



  factory HoldingRequestModel.fromEntity(HoldingRequestParams params) {
    return HoldingRequestModel(
      inputType: params.inputType,
      inputValue: params.inputValue,
      dob: params.dob,
      source: params.source,
      tokenId: params.tokenId,
      iv: params.iv,
      data: Data(
        requestDateTime: params.data.requestDateTime,
        merchantCode: params.data.merchantCode,
        holdingType: params.data.holdingType,
        isin: params.data.isin,
        messageSeq: params.data.messageSeq,
        dpid: params.data.dpid,
        dpName: params.data.dpName,
        dpAccount: params.data.dpAccount,
      ),
    );
  }
}

class Data {
  String? requestDateTime;
  String? merchantCode;
  String? holdingType;
  String? isin;
  String? messageSeq;
  String? dpid;
  String? dpName;
  String? dpAccount;

  Data({
    this.requestDateTime,
    this.merchantCode,
    this.holdingType,
    this.isin,
    this.messageSeq,
    this.dpid,
    this.dpName,
    this.dpAccount,
  });

  Map<String, dynamic> toJson() => {
    "requestDateTime": requestDateTime,
    "merchantCode": merchantCode,
    "holdingType": holdingType,
    "isin": isin,
    "messageSeq": messageSeq,
    "dpid": dpid,
    "dpName": dpName,
    "dpAccount": dpAccount,
  };
}
