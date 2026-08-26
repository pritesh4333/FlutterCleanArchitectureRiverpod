

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/WLResponse_parmams.dart';
import '../controllers/wlDetails_controller.dart';

final watchSearchQueryProvider = StateProvider<String>((ref) {
  return '';
});

final watchSearchItemProvider = Provider<List<WatchlistItem>>((ref){
  final query = ref.watch(watchSearchQueryProvider);
  final allItems = ref.watch(wlDetailsControllerProvider);
  final items = allItems.valueOrNull?.items ?? [];
  if(query.isEmpty) return items;
  return items.where((item) => item.symbol.toString().toLowerCase().contains(query.toString().toLowerCase())).toList();
});