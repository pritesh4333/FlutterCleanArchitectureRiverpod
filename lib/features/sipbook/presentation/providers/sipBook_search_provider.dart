import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/sipBook_controller.dart';
import '../../domain/entity/sipBookResponse_params.dart';

final sipBookSearchQueryProvider = StateProvider<String>((ref) {
  return "";
});

final sipBookSearchItemProvider = Provider<List<SipBookItem>>((ref) {
  final query = ref.watch(sipBookSearchQueryProvider).trim().toLowerCase();
  final allItems = ref.watch(sipBookDetailsControllerProvider);
  final items = allItems.valueOrNull?.items ?? [];
  if (query.isEmpty) return items;
  return items.where((item) {
    final symbolMatches = item.symbol.toLowerCase().contains(query);
    final templateMatches = item.templateName.toLowerCase().contains(query);
    final orderNoMatches = item.orderNumber.toLowerCase().contains(query);
    return symbolMatches || templateMatches || orderNoMatches;
  }).toList();
});

