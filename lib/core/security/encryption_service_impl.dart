import 'encryption_helper.dart';
import 'encryption_service.dart';

class EncryptionServiceImpl implements EncryptionService {
  @override
  List<String> encrypt(String plainText, String aesKeyBase64) {
    return EncryptionHelper.encrypt_(plainText, aesKeyBase64);
  }
  @override
  String decrypt(String encryptedBase64, String ivBase64, String aesKeyBase64) {
    return EncryptionHelper.decrypt_(encryptedBase64, ivBase64, aesKeyBase64);
  }
}