import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/network/failure.dart';
import '../../domain/entity/sipBookRequest_params.dart';
import '../../domain/entity/sipBookResponse_params.dart';
import '../../domain/repository/SipBookRepository.dart';
import '../datasource/sipBookRemoteDataSource.dart';
import '../model/sipBookRequestModel.dart';

class SipBookRepositoryImpl implements SipBookRepository {
  final SipBookRemoteDataSource remote;
  SipBookRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, SipBookResponseParams>> getSipBook(SipBookItemRequestParams params) async {
    try {
      final requestModel = SipBookItemRequestModel.fromEntity(params);
      final responseModel = await remote.getSipDetails(requestModel);
      return Right(responseModel as SipBookResponseParams);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

