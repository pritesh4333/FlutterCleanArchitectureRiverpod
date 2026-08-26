import 'package:fpdart/fpdart.dart';
import '../../../../core/network/failure.dart';
import '../entity/sipBookRequest_params.dart';
import '../entity/sipBookResponse_params.dart';
import '../repository/SipBookRepository.dart';

class SipBookDetailsUseCase {
  final SipBookRepository repository;
  SipBookDetailsUseCase(this.repository);

  Future<Either<Failure, SipBookResponseParams>> call(SipBookItemRequestParams params) {
    return repository.getSipBook(params);
  }
}

