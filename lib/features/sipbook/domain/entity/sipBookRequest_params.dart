class SipBookItemRequestParams {
  int inputType;
  String inputValue;
  String dob;
  String source;
  String tokenId;
  String iv;
  SipBookData data;

  SipBookItemRequestParams({
    required this.inputType,
    required this.inputValue,
    required this.dob,
    required this.source,
    required this.tokenId,
    required this.iv,
    required this.data,
  });
}

class SipBookData {
  String clientId;
  String product;

  SipBookData({
    required this.clientId,
    required this.product,
  });
}

