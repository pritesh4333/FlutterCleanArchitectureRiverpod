class PassAuthParams {
  final String entityId;
  final int inputType;
  final String inputValue;
  final String dob;
  final String source;

  final int authenticationType;
  final String authenticationValue;
  final int entityIdType;
  final String loginTerminal;
  final int secondFactorType;
  final String secondFactorValue;

  final String aesKey;
  final String imeiNo;
  final String iv;
  final String tokenId;

  const PassAuthParams({
    required this.entityId,
    required this.inputType,
    required this.inputValue,
    required this.dob,
    required this.source,
    required this.authenticationType,
    required this.authenticationValue,
    required this.entityIdType,
    required this.loginTerminal,
    required this.secondFactorType,
    required this.secondFactorValue,
    required this.aesKey,
    required this.imeiNo,
    required this.iv,
    required this.tokenId,
  });
}