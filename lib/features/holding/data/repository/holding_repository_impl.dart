import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:stockholding/features/holding/domain/entity/HoldingRequest_parmars.dart';

import '../../../../core/network/failure.dart';
 import '../../domain/entity/HoldingResponse_parmams.dart';
import '../../domain/repository/holdingRepository.dart';
import '../datasource/holdingRemoteDataSource.dart';
import '../model/HoldingRequestModel.dart';

class HoldingRepositoryImpl implements HoldingRepository {
  final HoldingRemoteDataSource remote;
  HoldingRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, HoldingResponseParams>> getHoldingDetails(HoldingRequestParams params) async {
    try {
      final requestModel = HoldingRequestModel.fromEntity(params);
      final responseModel = await remote.getHoldingDetails(requestModel);
      return Right(responseModel);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}