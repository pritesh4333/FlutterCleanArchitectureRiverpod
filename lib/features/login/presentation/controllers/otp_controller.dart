// presentation/controllers/otp_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecase/verify_otp_usecase.dart';

// state: null = idle, true = success, false = invalid otp (shown via AsyncError instead)
class OtpController extends StateNotifier<AsyncValue<bool?>> {
  final VerifyOtpUseCase _verifyOtpUseCase;

  OtpController(this._verifyOtpUseCase) : super(const AsyncData(null));

  Future<void> submitOtp(String otp) async {
    if (otp.length != 6) {
      state = AsyncError('Please enter all 6 digits', StackTrace.current);
      return;
    }

    state = const AsyncLoading();

    final isValid = await _verifyOtpUseCase(otp);

    if (isValid) {
      state = const AsyncData(true);
    } else {
      state = AsyncError('Invalid OTP. Please try again.', StackTrace.current);
    }
  }

  void reset() {
    state = const AsyncData(null);
  }
}