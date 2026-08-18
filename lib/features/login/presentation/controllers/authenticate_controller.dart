 import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockholding/features/login/presentation/provider/auth_providers.dart';
import '../../domain/entities/authenticate_params.dart';
import '../../domain/entities/authenticate_result.dart';

class AuthenticateController extends AsyncNotifier<AuthenticateResult?> {
  @override
  FutureOr<AuthenticateResult?> build() => null;

  Future<void> authenticate(AuthenticateParams params) async {
    state = const AsyncLoading();

    final useCase = ref.read(authenticateUseCaseProvider);//step 2
    final result = await useCase(params);

    // fold() converts Either<Failure, T> into AsyncValue manually
    state = result.match( // step 11
          (failure) => AsyncError<AuthenticateResult?>(failure.message, StackTrace.current),
          (data) => AsyncData<AuthenticateResult?>(data),
    );
  }
}

final authenticateControllerProvider =
AsyncNotifierProvider<AuthenticateController, AuthenticateResult?>(
  AuthenticateController.new,
);