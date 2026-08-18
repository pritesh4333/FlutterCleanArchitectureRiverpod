import 'package:fpdart/fpdart.dart';
import '../../../../core/network/failure.dart';
import '../entity/positionRequest_parmars.dart';
import '../entity/positionResponse_parmams.dart';
import '../repository/positionRepository.dart';

class PositionDetailsUseCase {
  final PositionRepository repository;
  PositionDetailsUseCase(this.repository);

  Future<Either<Failure, PositionResponseParams>> call(PositionRequestParmas params) {
    return repository.getPostionBook(params);
  }
}