import 'package:fpdart/fpdart.dart';
import 'package:stockholding/features/holding/domain/entity/HoldingRequest_parmars.dart';
import 'package:stockholding/features/holding/domain/entity/HoldingResponse_parmams.dart';
import '../../../../core/network/failure.dart';
 import '../repository/holdingRepository.dart';

class HoldingUseCase {
  final HoldingRepository repository;
  HoldingUseCase(this.repository);

  Future<Either<Failure, HoldingResponseParams>> call(HoldingRequestParams params) {
    return repository.getHoldingDetails(params);
  }
}