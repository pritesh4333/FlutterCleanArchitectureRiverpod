abstract class EncryptionService {
  /// Returns [encryptedBase64, ivBase64]
  List<String> encrypt(String plainText, String aesKeyBase64);
  /// Decrypts data encrypted with AES-CBC.
  String decrypt(String encryptedBase64, String ivBase64, String aesKeyBase64);
}