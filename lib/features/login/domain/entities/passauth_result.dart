abstract class PassAuthResult {
  String get status;
  String get errorCode;
  String get message;
  String get iv;
  String get data; // AES-encrypted payload, decrypt client-side with aes_key + this iv
  bool get isSuccess;
}