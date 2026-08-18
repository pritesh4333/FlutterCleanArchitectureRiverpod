class AuthenticateResult {
  final String status;
  final String errorCode;
  final String message;
  final List<EncryptedData> data;

  /// Decrypted AES key — filled in by the presentation after RSA-decrypting
  /// data[0].encryptedKey. Empty until that happens (or on failure).
  final String decryptedAesKey;

  /// Decrypted token id — filled in by the presentation after RSA-decrypting
  /// data[0].encryptedToken. Empty until that happens (or on failure).
  final String decryptedTokenId;

  const AuthenticateResult({
    required this.status,
    required this.errorCode,
    required this.message,
    required this.data,
    this.decryptedAesKey = '',
    this.decryptedTokenId = '',
  });

  bool get isSuccess => status.toLowerCase().trim() == 'success';

  AuthenticateResult copyWithDecrypted({
    required String decryptedAesKey,
    required String decryptedTokenId,
  }) {
    return AuthenticateResult(
      status: status,
      errorCode: errorCode,
      message: message,
      data: data,
      decryptedAesKey: decryptedAesKey,
      decryptedTokenId: decryptedTokenId,
    );
  }
}

class EncryptedData {
  final String encryptedKey;
  final String encryptedToken;

  const EncryptedData({
    required this.encryptedKey,
    required this.encryptedToken,
  });
}