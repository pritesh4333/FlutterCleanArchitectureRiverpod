import 'package:fpdart/fpdart.dart';

import '../../../../core/network/failure.dart';
import '../entity/sipBookRequest_params.dart';
import '../entity/sipBookResponse_params.dart';

abstract class SipBookRepository {
  Future<Either<Failure, SipBookResponseParams>> getSipBook(
    SipBookItemRequestParams params,
  );
}

