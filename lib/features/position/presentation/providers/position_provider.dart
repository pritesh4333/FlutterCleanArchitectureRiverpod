import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockholding/features/watchlist/domain/usecase/wldetails_usecase.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../core/security/security_providers.dart';
import '../../data/datasource/positionRemoteDataSource.dart';
import '../../data/repository/position_repository_impl.dart';
import '../../domain/repository/positionRepository.dart';
import '../../domain/usecase/position_usecase.dart';


final positionRemoteDataSourceProvider = Provider<PositionRemoteDataSource>((ref) {
  return PositionRemoteDataSourceImpl(
    ref.watch(dioProvider),
    ref.watch(encryptionServiceProvider),
  );
});

final positionRepositoryProvider = Provider<PositionRepository>((ref) {
  return PositionRepositoryImpl(
    ref.watch(positionRemoteDataSourceProvider),
   );
});



final positionDetailsUseCaseProvider = Provider<PositionDetailsUseCase>((ref) {
  return PositionDetailsUseCase(ref.watch(positionRepositoryProvider));
});