
import 'package:fpdart/fpdart.dart';

import '../../../../core/network/failure.dart';
import '../entity/WLRequest_parmars.dart';
import '../entity/WLResponse_parmams.dart';


abstract class WatchRepository {

  Future<Either<Failure, WlResponseParams>> getWLDetails(
      WlRequestParams params,
      );
}