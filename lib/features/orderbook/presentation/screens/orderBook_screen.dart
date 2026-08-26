import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/ListSkeleton.dart';

import '../controllers/orderBook_controller.dart';
import '../providers/orderBook_search_provider.dart';

class OrderBookScreen extends ConsumerStatefulWidget {
  const OrderBookScreen({super.key});

  @override
  ConsumerState<OrderBookScreen> createState() => _OrderBookScreenScreenState();
}

class _OrderBookScreenScreenState extends ConsumerState<OrderBookScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      ref.read(orderBookSearchQueryProvider.notifier).state = value;
    });
  }

  void _clearSearch() {
    _debounce?.cancel();
    _searchController.clear();
    ref.read(orderBookSearchQueryProvider.notifier).state = '';
  }

  @override
  Widget build(BuildContext context) {
    final wlDetailsState = ref.watch(orderBokDetailsControllerProvider);

    return Scaffold(
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
              const Expanded(child: _OrderBookList()),
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
    final searchQuery = ref.watch(orderBookSearchQueryProvider);

    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Search by symbol, exchange...',
            border: const OutlineInputBorder(),
            suffixIcon: searchQuery.isEmpty
                ? null
                : IconButton(
              icon: const Icon(Icons.clear),
              onPressed: onClear,
            ),
          ),
          onChanged: onChanged,
        ),
       Padding(
         padding: EdgeInsets.all(5),
           child: Text("Click item for more details")),
      ],
    );
  }
}

/// Isolated so only this rebuilds when the filtered list changes —
/// not the search field or the rest of the screen.
class _OrderBookList extends ConsumerWidget {
  const _OrderBookList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredItems = ref.watch(orderBookSearchItemProvider);

    if (filteredItems.isEmpty) {
      return const Center(child: Text('No matching instruments'));
    }

    return ListView.builder(
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
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
  }
}