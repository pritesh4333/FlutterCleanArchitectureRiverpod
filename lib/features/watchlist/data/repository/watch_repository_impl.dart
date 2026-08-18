import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/network/failure.dart';
import '../../domain/entity/WLRequest_parmars.dart';
import '../../domain/entity/WLResponse_parmams.dart';
import '../../domain/repository/WatchRepository.dart';
import '../datasource/watchRemoteDataSource.dart';
import '../model/WlRequestModel.dart';

class WatchRepositoryImpl implements WatchRepository {
  final WatchRemoteDataSource remote;
  WatchRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, WlResponseParams>> getWLDetails(WlRequestParams params) async {
    try {
      final requestModel = WlRequestModelParams.fromEntity(params);
      final responseModel = await remote.getWlDetails(requestModel);
      return Right(responseModel);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}