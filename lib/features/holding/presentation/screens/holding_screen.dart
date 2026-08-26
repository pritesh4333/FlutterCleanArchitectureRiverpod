import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 import '../../../../core/widgets/ListSkeleton.dart';
 import '../../domain/entity/HoldingResponse_parmams.dart';
import '../controllers/holding_controller.dart';


class HoldingScreen extends ConsumerStatefulWidget {
  const HoldingScreen({super.key});

  @override
  ConsumerState<HoldingScreen> createState() => _HoldingScreenState();
}

class _HoldingScreenState extends ConsumerState<HoldingScreen> {

  @override
  Widget build(BuildContext context) {
    final holdingDetailsState = ref.watch(holdingDetailsControllerProvider);

    return Scaffold(
      body: holdingDetailsState.when(
        loading: () => const ListSkeleton(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (result) {
          if (result == null) return const Center(child: Text('No data'));
          if (result.status!="success") return Center(child: Text(result.message));
          if (result.items!.records!.isEmpty)
            return const Center(child: Text('No instruments found'));

          return ListView.builder(
            itemCount: result.items!.records!.length,
            itemBuilder: (context, index) {
              // Key by socketKey so Flutter can diff rows correctly across rebuilds
              final item = result.items!.records![index];
              return RepaintBoundary(
                child: _HoldingRow(key: ValueKey(item), item: item),
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

class _HoldingRow extends ConsumerWidget {
  final Record item;

  const _HoldingRow({required super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      title: Text(item.nseSymbol),
      subtitle: Text('${item.isin} • ${item.freeQty}'),
      trailing: Text('Ltp: ${item.freeQty}', style: const TextStyle(fontSize: 12)),
    );
  }
}
