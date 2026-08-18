

import 'dart:convert';
import 'dart:math';

import 'package:encrypt/encrypt.dart';


class EncryptionHelper {
  static List<String> encrypt_(String plainText, var global_aes) {
    final key = Key.fromBase64(global_aes);
    final iv = IV.fromBase64(EncryptionHelper.randomString(16));

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    var encrypted = encrypter.encrypt(plainText, iv: iv);

    return [encrypted.base64, iv.base64];
  }

  static String decrypt_(String encryptedText, String iv, var global_aes) {
    final key = Key.fromBase64(global_aes);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final ivector = IV.fromBase64(iv);

    var decryptor = encrypter.decrypt64(encryptedText, iv: ivector);
    return decryptor;
  }
  static String randomString(int strlen) {
    const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
    Random rnd = Random.secure();
    String result = "";
    for (var i = 0; i < strlen; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }

    var bytes = utf8.encode(result);
    var base64Str = base64.encode(bytes);
    return base64Str;
  }
}