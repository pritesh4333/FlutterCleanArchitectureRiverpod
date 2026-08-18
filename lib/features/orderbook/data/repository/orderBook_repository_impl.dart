import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:stockholding/features/orderbook/data/datasource/orderBookRemoteDataSource.dart';
import 'package:stockholding/features/orderbook/domain/entity/orderBookRequest_parmars.dart';
import 'package:stockholding/features/orderbook/domain/entity/orderBookResponse_parmams.dart';

import '../../../../core/network/failure.dart';
 import '../../domain/repository/OrderBookRepository.dart';
 import '../model/orderBookRequestModel.dart';

class OrderBookRepositoryImpl implements OrderBookRepository {
  final OrderBookRemoteDataSource remote;
  OrderBookRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, OrderBookResponseParams>> getOrderBook(OrderBookItemRequestParmas params) async {
    // TODO: implement getOrderBookDetails
    try {
      final requestModel = OrderBookItemRequestModel.fromEntity(params);
      final responseModel = await remote.getOrderDetails(requestModel);
      return Right(responseModel as OrderBookResponseParams);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }




}