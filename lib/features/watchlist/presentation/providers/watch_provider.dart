import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockholding/features/watchlist/domain/usecase/wldetails_usecase.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../core/security/security_providers.dart';
import '../../data/datasource/watchRemoteDataSource.dart';
import '../../data/repository/watch_repository_impl.dart';
import '../../domain/repository/WatchRepository.dart';


final watchRemoteDataSourceProvider = Provider<WatchRemoteDataSource>((ref) {
  return WatchRemoteDataSourceImpl(
    ref.watch(dioProvider),
    ref.watch(encryptionServiceProvider),
  );
});

final watchRepositoryProvider = Provider<WatchRepository>((ref) {
  return WatchRepositoryImpl(
    ref.watch(watchRemoteDataSourceProvider),
   );
});



final wlDetailsUseCaseProvider = Provider<WlDetailsUseCase>((ref) {
  return WlDetailsUseCase(ref.watch(watchRepositoryProvider));
});