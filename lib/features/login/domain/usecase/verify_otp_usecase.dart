// domain/usecases/verify_otp_usecase.dart

import '../repository/otp_repository.dart';

class VerifyOtpUseCase {
  final OtpRepository repository;
  VerifyOtpUseCase(this.repository);

  Future<bool> call(String otp) {
    return repository.verifyOtp(otp);
  }
}