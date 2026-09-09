// data/repositories/otp_repository_impl.dart

import '../../domain/repository/otp_repository.dart';

class OtpRepositoryImpl implements OtpRepository {
  static const String _hardcodedOtp = '111111';

  @override
  Future<bool> verifyOtp(String otp) async {
    // Simulate network delay — swap this whole method body
    // for a real API call later without touching the UI/controller.
    await Future.delayed(const Duration(milliseconds: 600));
    return otp == _hardcodedOtp;
  }
}