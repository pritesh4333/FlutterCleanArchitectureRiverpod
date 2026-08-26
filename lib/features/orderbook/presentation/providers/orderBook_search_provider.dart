

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockholding/features/orderbook/domain/entity/orderBookResponse_parmams.dart';

import '../controllers/orderBook_controller.dart';

final orderBookSearchQueryProvider= StateProvider<String>((ref) {
  return "";
});

final orderBookSearchItemProvider = Provider<List<OrderBookItem>>((ref) {

  final query = ref.watch(orderBookSearchQueryProvider);
  final allItems = ref.watch(orderBokDetailsControllerProvider);
  final items = allItems.valueOrNull?.items ?? [];
  if (query.isEmpty) return items;
  return items.where((item) => item.symbol.toString().toLowerCase().contains(query.toString().toLowerCase())).toList();
});
