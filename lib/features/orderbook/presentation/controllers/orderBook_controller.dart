import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/globalVariables.dart';
import '../../domain/entity/orderBookRequest_parmars.dart';
import '../../domain/entity/orderBookResponse_parmams.dart';

import '../providers/orderBook_provider.dart';


class OrderBookDetailsController extends AsyncNotifier<OrderBookResponseParams?> {
  @override
  Future<OrderBookResponseParams?> build() async {
    await Future.delayed(const Duration(seconds: 3));
    final params = OrderBookItemRequestParmas(
      inputType: 2,
      inputValue: clientId!,
      dob: dob!,
      source: 'M',
      tokenId: tokenID!,
      iv: iV!,
      data: OrderBookData(
        source: 'M',
        sortBy: 'order_date_time',
        clientId: clientId!,
        bankAccountSettlementType: '0',
      ),
    );

    final result = await ref
        .read(orderBookDetailsUseCaseProvider)
        .call(params);

    return result.fold(
          (failure) {
        throw Exception(failure.message);
      },
          (response) {
        return response;
      },
    );
  }

  Future<void> getOrderBookDetails(OrderBookItemRequestParmas params) async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 3));
    final useCase = ref.read(orderBookDetailsUseCaseProvider); // step 2
    final result = await useCase(params);

    // fold()/match() converts Either<Failure, T> into AsyncValue manually
    state = result.match(
          (failure) => AsyncError<OrderBookResponseParams?>(failure.message, StackTrace.current),
          (data) => AsyncData<OrderBookResponseParams?>(data),
    );
  }
}

final orderBokDetailsControllerProvider =
AsyncNotifierProvider<OrderBookDetailsController, OrderBookResponseParams?>(
  OrderBookDetailsController.new,
);