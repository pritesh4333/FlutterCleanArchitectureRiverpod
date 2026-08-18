import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/passauth_params.dart';
import '../../domain/entities/passauth_result.dart';
import '../provider/auth_providers.dart';

class PassAuthController extends AsyncNotifier<PassAuthResult?> {
  @override
  FutureOr<PassAuthResult?> build() => null;

  Future<void> passAuth(PassAuthParams params) async {
    state = const AsyncLoading();

    final useCase = ref.read(passAuthUseCaseProvider);
    final result = await useCase(params);

    state = result.match(
          (failure) => AsyncError<PassAuthResult?>(failure.message, StackTrace.current),
          (data) => AsyncData<PassAuthResult?>(data),
    );
  }
}

final passAuthControllerProvider =
AsyncNotifierProvider<PassAuthController, PassAuthResult?>(
  PassAuthController.new,
);