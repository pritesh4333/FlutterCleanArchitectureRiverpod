import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_provider.dart';
import '../../../../core/security/security_providers.dart';
import '../../data/datasource/sipBookRemoteDataSource.dart';
import '../../data/repository/sipBook_repository_impl.dart';
import '../../domain/repository/SipBookRepository.dart';
import '../../domain/usecase/sipBookDetails_usecase.dart';

final sipBookRemoteDataSourceProvider = Provider<SipBookRemoteDataSource>((ref) {
  return SipBookRemoteDataSourceImpl(
    ref.watch(dioProvider),
    ref.watch(encryptionServiceProvider),
  );
});

final sipBookRepositoryProvider = Provider<SipBookRepository>((ref) {
  return SipBookRepositoryImpl(
    ref.watch(sipBookRemoteDataSourceProvider),
  );
});

final sipBookDetailsUseCaseProvider = Provider<SipBookDetailsUseCase>((ref) {
  return SipBookDetailsUseCase(ref.watch(sipBookRepositoryProvider));
});

