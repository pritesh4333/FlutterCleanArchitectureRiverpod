class WlRequestParams {
  int inputType;
  String inputValue;
  String dob;
  String source;
  String tokenId;
  String iv;
  Data data;

  WlRequestParams({
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
  String wlName;
  String clientId;

  Data({
    required this.wlName,
    required this.clientId,
  });

}
