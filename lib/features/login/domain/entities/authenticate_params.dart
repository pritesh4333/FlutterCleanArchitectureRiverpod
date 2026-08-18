class AuthenticateParams {
  final int inputType;
  final String inputValue;
  final String dob;
  final String tokenId;
  final String iv;
  final String passFlag;
  final String source;

  const AuthenticateParams({
    required this.inputType,
    required this.inputValue,
    required this.dob,
    required this.tokenId,
    required this.iv,
    required this.passFlag,
    this.source = 'M',
  });
}