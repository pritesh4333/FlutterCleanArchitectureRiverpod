
import 'package:fpdart/fpdart.dart';

import '../../../../core/network/failure.dart';
import '../entity/positionRequest_parmars.dart';
import '../entity/positionResponse_parmams.dart';


abstract class PositionRepository {

  Future<Either<Failure, PositionResponseParams>> getPostionBook(
      PositionRequestParmas params,
      );
}