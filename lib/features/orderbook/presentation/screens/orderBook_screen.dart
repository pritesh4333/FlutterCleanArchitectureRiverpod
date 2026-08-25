import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../controllers/orderBook_controller.dart';

class OrderBookScreen extends ConsumerStatefulWidget {
  const OrderBookScreen({super.key});

  @override
  ConsumerState<OrderBookScreen> createState() => _OrderBookScreenScreenState();
}

class _OrderBookScreenScreenState extends ConsumerState<OrderBookScreen> {
  @override
  Widget build(BuildContext context) {
    final wlDetailsState = ref.watch(orderBokDetailsControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('OrderBooks')),
      body: wlDetailsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (result) {
          if (result == null) return const Center(child: Text('No data'));
          if (!result.isSuccess) return Center(child: Text(result.message));
          if (result.items.isEmpty) {
            return const Center(child: Text('No instruments found'));
          }

          return ListView.builder(
            itemCount: result.items.length,
            itemBuilder: (context, index) {
              final item = result.items[index];
              return ListTile(
                title: Text(item.symbol),
                subtitle: Text('${item.exchange} • ${item.instrument}'),
                trailing: Text(
                  '${item.price}',
                  style: const TextStyle(fontSize: 12),
                ),
                onTap: () {
                  context.pushNamed('orderBookDetail', extra: item);
                },
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}