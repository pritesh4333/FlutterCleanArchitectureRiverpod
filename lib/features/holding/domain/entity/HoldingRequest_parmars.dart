class HoldingRequestParams {
  int inputType;
  String inputValue;
  String dob;
  String source;
  String tokenId;
  String iv;
  Data data;

  HoldingRequestParams({
    required this.inputType,
    required this.inputValue,
    required this.dob,
    required this.source,
    required this.tokenId,
    required this.iv,
    required this.data,
  });

}

class Data {
  String requestDateTime;
  String merchantCode;
  String holdingType;
  String isin;
  String messageSeq;
  String dpid;
  String dpName;
  String dpAccount;

  Data({
    required this.requestDateTime,
    required this.merchantCode,
    required this.holdingType,
    required this.isin,
    required this.messageSeq,
    required this.dpid,
    required this.dpName,
    required this.dpAccount,
  });

}
