import 'package:fpdart/fpdart.dart';
import 'package:stockholding/features/watchlist/domain/entity/WLRequest_parmars.dart';
import 'package:stockholding/features/watchlist/domain/entity/WLResponse_parmams.dart';
import '../../../../core/network/failure.dart';
import '../repository/WatchRepository.dart';

class WlDetailsUseCase {
  final WatchRepository repository;
  WlDetailsUseCase(this.repository);

  Future<Either<Failure, WlResponseParams>> call(WlRequestParams params) {
    return repository.getWLDetails(params);
  }
}