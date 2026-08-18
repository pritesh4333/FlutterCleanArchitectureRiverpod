import 'package:fpdart/fpdart.dart';
import '../../../../core/network/failure.dart';
import '../entity/orderBookRequest_parmars.dart';
import '../entity/orderBookResponse_parmams.dart';
import '../repository/OrderBookRepository.dart';

class OrderBookDetailsUseCase {
  final OrderBookRepository repository;
  OrderBookDetailsUseCase(this.repository);

  Future<Either<Failure, OrderBookResponseParams>> call(OrderBookItemRequestParmas params) {
    return repository.getOrderBook(params);
  }
}