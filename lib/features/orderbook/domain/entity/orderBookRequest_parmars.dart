class OrderBookItemRequestParmas {
  int inputType;
  String inputValue;
  String dob;
  String source;
  String tokenId;
  String iv;
  OrderBookData data;

  OrderBookItemRequestParmas({
    required this.inputType,
    required this.inputValue,
    required this.dob,
    required this.source,
    required this.tokenId,
    required this.iv,
    required this.data,
  });

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

}
