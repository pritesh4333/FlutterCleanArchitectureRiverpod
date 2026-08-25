

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockholding/features/holding/domain/repository/holdingRepository.dart';

import '../../../../core/network/dio_provider.dart';
import '../../../../core/security/security_providers.dart';
import '../../data/datasource/holdingRemoteDataSource.dart';
 import '../../data/repository/holding_repository_impl.dart';
import '../../domain/usecase/holding_usecase.dart';

final holdingRemoteDataSourceProvider = Provider<HoldingRemoteDataSource>((ref) {
  return HoldingRemoteDataSourceImpl(
    ref.watch(dioProvider),
    ref.watch(encryptionServiceProvider),
  );
});

final holdingRepositoryProvider = Provider<HoldingRepository>((ref) {
  return HoldingRepositoryImpl(
    ref.watch(holdingRemoteDataSourceProvider),
   );
});



final holdingDetailsUseCaseProvider = Provider<HoldingUseCase>((ref) {
  return HoldingUseCase(ref.watch(holdingRepositoryProvider));
});