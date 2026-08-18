class PositionRequestParmas {
  int inputType;
  String inputValue;
  String dob;
  String source;
  String tokenId;
  String iv;
  PositionData data;

  PositionRequestParmas({
    required this.inputType,
    required this.inputValue,
    required this.dob,
    required this.source,
    required this.tokenId,
    required this.iv,
    required this.data,
  });

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

}
