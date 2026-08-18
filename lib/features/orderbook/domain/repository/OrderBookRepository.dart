
import 'package:fpdart/fpdart.dart';

import '../../../../core/network/failure.dart';
import '../entity/orderBookRequest_parmars.dart';
import '../entity/orderBookResponse_parmams.dart';


abstract class OrderBookRepository {

  Future<Either<Failure, OrderBookResponseParams>> getOrderBook(
      OrderBookItemRequestParmas params,
      );
}