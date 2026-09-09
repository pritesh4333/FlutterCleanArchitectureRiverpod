// domain/repositories/otp_repository.dart
abstract class OtpRepository {
  Future<bool> verifyOtp(String otp);
}