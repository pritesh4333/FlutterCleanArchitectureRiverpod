import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:stockholding/features/orderbook/data/datasource/orderBookRemoteDataSource.dart';
import 'package:stockholding/features/orderbook/domain/entity/orderBookRequest_parmars.dart';
import 'package:stockholding/features/orderbook/domain/entity/orderBookResponse_parmams.dart';

import '../../../../core/network/failure.dart';
 import '../../domain/entity/positionRequest_parmars.dart';
import '../../domain/entity/positionResponse_parmams.dart';
import '../../domain/repository/positionRepository.dart';
 import '../datasource/positionRemoteDataSource.dart';
import '../model/positionRequestModel.dart';

class PositionRepositoryImpl implements PositionRepository {
  final PositionRemoteDataSource remote;
  PositionRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, PositionResponseParams>> getPostionBook(PositionRequestParmas params) async {
    // TODO: implement getOrderBookDetails
    try {
      final requestModel = PositionRequestModel.fromEntity(params);
      final responseModel = await remote.getPostionDetails(requestModel);
      return Right(responseModel as PositionResponseParams);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }




}