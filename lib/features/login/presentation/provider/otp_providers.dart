// presentation/providers/otp_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
   import '../../data/repository/otp_repository_impl.dart';
import '../../domain/repository/otp_repository.dart';
import '../../domain/usecase/verify_otp_usecase.dart';
import '../controllers/otp_controller.dart';

final otpRepositoryProvider = Provider<OtpRepository>((ref) {
  return OtpRepositoryImpl();
});

final verifyOtpUseCaseProvider = Provider<VerifyOtpUseCase>((ref) {
  return VerifyOtpUseCase(ref.watch(otpRepositoryProvider));
});

final otpControllerProvider =
StateNotifierProvider.autoDispose<OtpController, AsyncValue<bool?>>((ref) {
  return OtpController(ref.watch(verifyOtpUseCaseProvider));
});