import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockholding/features/watchlist/domain/usecase/wldetails_usecase.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../core/security/security_providers.dart';
import '../../data/datasource/orderBookRemoteDataSource.dart';
import '../../data/repository/orderBook_repository_impl.dart';
import '../../domain/repository/OrderBookRepository.dart';
import '../../domain/usecase/orderBookdetails_usecase.dart';


final orderBookRemoteDataSourceProvider = Provider<OrderBookRemoteDataSource>((ref) {
  return OrderBookRemoteDataSourceImpl(
    ref.watch(dioProvider),
    ref.watch(encryptionServiceProvider),
  );
});

final orderBookRepositoryProvider = Provider<OrderBookRepository>((ref) {
  return OrderBookRepositoryImpl(
    ref.watch(orderBookRemoteDataSourceProvider),
   );
});



final orderBookDetailsUseCaseProvider = Provider<OrderBookDetailsUseCase>((ref) {
  return OrderBookDetailsUseCase(ref.watch(orderBookRepositoryProvider));
});