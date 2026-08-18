import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockholding/core/constants/globalVariables.dart';
import '../../domain/entity/WLRequest_parmars.dart';
import '../../domain/entity/WLResponse_parmams.dart';
import '../controllers/wlDetails_controller.dart';
import '../controllers/watchlist_socket_controller.dart';
import 'package:collection/collection.dart';

class WatchlistScreen extends ConsumerStatefulWidget {
  const WatchlistScreen({super.key});

  @override
  ConsumerState<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends ConsumerState<WatchlistScreen> {
  bool _broadcastStarted = false;

  // Captured once we first need it. Riverpod doesn't allow ref.read/ref.watch
  // inside dispose() (ref may already be detached by then), so we grab the
  // controller reference here in build() and call methods on this captured
  // object in dispose() instead of doing ref.read(...) there.
  WatchlistSocketController? _socketController;



  @override
  Widget build(BuildContext context) {
    final wlDetailsState = ref.watch(wlDetailsControllerProvider);

    // Start the socket subscription once, right after data first loads.
    if (!_broadcastStarted && wlDetailsState.value?.isSuccess == true) {
      _broadcastStarted = true;
      _socketController = ref.read(watchlistSocketControllerProvider);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // TODO: this should come from the same source as entityId used
        // elsewhere in the app (currently hardcoded there too) — replace
        // with a real client ID once that's threaded through properly.
        _socketController?.startBroadcast(clientId: 'EKS560743');
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Watchlist')),
      body: wlDetailsState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (result) {
          if (result == null) return const Center(child: Text('No data'));
          if (!result.isSuccess) return Center(child: Text(result.message));
          if (result.items.isEmpty)
            return const Center(child: Text('No instruments found'));

          return ListView.builder(
            itemCount: result.items.length,
            itemBuilder: (context, index) {
              // Key by socketKey so Flutter can diff rows correctly across rebuilds
              final item = result.items[index];
              return RepaintBoundary(
                child: _WatchlistRow(key: ValueKey(item.socketKey), item: item),
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _socketController?.dispose();
    super.dispose();
  }
}

class _WatchlistRow extends ConsumerWidget {
  final WatchlistItem item;

  const _WatchlistRow({required super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // select() only rebuilds THIS row when this item's refLtp actually
    // changes — not on every tick for every other symbol.
    final refLtp = ref.watch(
      wlDetailsControllerProvider.select((state) {
        final items = state.value?.items;
        if (items == null) return item.refLtp;
        final match = items.firstWhereOrNull(
          (i) => i.socketKey == item.socketKey,
        );
        return match?.refLtp ?? item.refLtp;
      }),
    );

    return ListTile(
      title: Text(item.symbol),
      subtitle: Text('${item.exchange} • ${item.instrument}'),
      trailing: Text('Ltp: $refLtp', style: const TextStyle(fontSize: 12)),
    );
  }
}
