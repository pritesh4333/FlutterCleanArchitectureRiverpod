import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockholding/features/login/data/repository/auth_repository_impl.dart';
import 'package:stockholding/features/watchlist/domain/entity/WLRequest_parmars.dart';
import 'package:stockholding/features/login/domain/repository/authRepository.dart';
import 'package:stockholding/features/login/domain/usecase/authenticate_usecase.dart';
import 'package:stockholding/features/watchlist/domain/usecase/wldetails_usecase.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../core/security/security_providers.dart';
import '../../data/datasource/auth_remote_data_source.dart';
import '../../domain/usecase/passauth_usecase.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(
    ref.watch(dioProvider),
    ref.watch(encryptionServiceProvider),
  );
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    ref.watch(authRemoteDataSourceProvider),
    ref.watch(rsaKeyHelperProvider), // new
  );
});

final authenticateUseCaseProvider = Provider<AuthenticateUseCase>((ref) {
  return AuthenticateUseCase(ref.watch(authRepositoryProvider)); //step 2
});

final passAuthUseCaseProvider = Provider<PassAuthUseCase>((ref) {
  return PassAuthUseCase(ref.watch(authRepositoryProvider));
});

