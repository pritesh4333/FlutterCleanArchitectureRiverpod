import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/widgets/ListSkeleton.dart';
import 'package:stockholding/features/position/presentation/providers/position_provider.dart';

import '../controllers/position_controller.dart';


class PositionScreen extends ConsumerStatefulWidget {
  const PositionScreen({super.key});

  @override
  ConsumerState<PositionScreen> createState() => _PositionScreenState();
}

class _PositionScreenState extends ConsumerState<PositionScreen> {

  @override
  Widget build(BuildContext context) {
    final positionDetailsState = ref.watch(positionControllerProvider);

    return Scaffold(

      body: positionDetailsState.when(
        loading: () => const ListSkeleton(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (result) {
          if (result == null) return const Center(child: Text('No data'));
          if (!result.isSuccess) return Center(child: Text(result.message));
          if (result.items.isEmpty)
            return const Center(child: Text('No instruments found'));

          return ListView.builder(
            itemCount: result.items.length,
            itemBuilder: (context, index) {
              final item = result.items[index];
              return ListTile(
                title: Text(item.symbol),
                subtitle: Text('${item.exchange} • ${item.buyAvg}'),
                trailing: Text(
                  '${item.grossQty}',
                  style: const TextStyle(fontSize: 12),
                ),
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
