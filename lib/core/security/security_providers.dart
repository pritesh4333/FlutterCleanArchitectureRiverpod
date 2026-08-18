import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'encryption_service.dart';
import 'encryption_service_impl.dart';
import 'RsaKeyHelper.dart';

final encryptionServiceProvider = Provider<EncryptionService>((ref) {
  return EncryptionServiceImpl();
});

final rsaKeyHelperProvider = Provider<RsaKeyHelper>((ref) {
  return RsaKeyHelper();
});