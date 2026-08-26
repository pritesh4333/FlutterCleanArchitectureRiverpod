import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stockholding/core/constants/globalVariables.dart';
import '../../../../core/widgets/ListSkeleton.dart';
import '../../domain/entity/WLRequest_parmars.dart';
import '../../domain/entity/WLResponse_parmams.dart';
import '../controllers/wlDetails_controller.dart';
import '../controllers/watchlist_socket_controller.dart';
 import 'package:collection/collection.dart';

import '../providers/watchSearchProvider.dart';

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

  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      ref.read(watchSearchQueryProvider.notifier).state = value;
    });
  }

  void _clearSearch() {
    _debounce?.cancel();
    _searchController.clear();
    ref.read(watchSearchQueryProvider.notifier).state = '';
  }

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
      appBar: AppBar(title: const Text('Watchlist'),
        backgroundColor: Theme.of(context).colorScheme.surface, // pin explicitly
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: wlDetailsState.when(
        loading: () => const ListSkeleton(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (result) {
          if (result == null) return const Center(child: Text('No data'));
          if (!result.isSuccess) return Center(child: Text(result.message));
          if (result.items.isEmpty) {
            return const Center(child: Text('No instruments found'));
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _SearchField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  onClear: _clearSearch,
                ),
              ),
              const Expanded(child: _WatchlistList()),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _socketController?.dispose();
    super.dispose();
  }
}

/// Isolated so only this rebuilds when the search query changes
/// (specifically, for the clear-icon visibility) — not the whole screen.
class _SearchField extends ConsumerWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const _SearchField({
    required this.controller,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(watchSearchQueryProvider);

    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Search by symbol...',
        border: const OutlineInputBorder(),
        suffixIcon: searchQuery.isEmpty
            ? null
            : IconButton(
          icon: const Icon(Icons.clear),
          onPressed: onClear,
        ),
      ),
      onChanged: onChanged,
    );
  }
}

/// Isolated so only this rebuilds when the filtered list changes —
/// not the search field.
class _WatchlistList extends ConsumerWidget {
  const _WatchlistList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredItems = ref.watch(watchSearchItemProvider);

    if (filteredItems.isEmpty) {
      return const Center(child: Text('No matching instruments'));
    }

    return ListView.builder(
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        // Key by socketKey so Flutter can diff rows correctly across rebuilds
        final item = filteredItems[index];
        return RepaintBoundary(
          child: _WatchlistRow(key: ValueKey(item.socketKey), item: item),
        );
      },
    );
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