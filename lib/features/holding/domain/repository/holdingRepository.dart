
import 'package:fpdart/fpdart.dart';
import 'package:stockholding/features/holding/domain/entity/HoldingRequest_parmars.dart';

import '../../../../core/network/failure.dart';
  import '../entity/HoldingResponse_parmams.dart';


abstract class HoldingRepository {

  Future<Either<Failure, HoldingResponseParams>> getHoldingDetails(
      HoldingRequestParams params,
      );
}