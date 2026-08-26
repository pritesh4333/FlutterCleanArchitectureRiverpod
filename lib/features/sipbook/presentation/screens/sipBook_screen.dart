import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/ListSkeleton.dart';

import '../controllers/sipBook_controller.dart';
import '../providers/sipBook_search_provider.dart';

class SipBookScreen extends ConsumerStatefulWidget {
  const SipBookScreen({super.key});

  @override
  ConsumerState<SipBookScreen> createState() => _SipBookScreenState();
}

class _SipBookScreenState extends ConsumerState<SipBookScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      ref.read(sipBookSearchQueryProvider.notifier).state = value;
    });
  }

  void _clearSearch() {
    _debounce?.cancel();
    _searchController.clear();
    ref.read(sipBookSearchQueryProvider.notifier).state = '';
  }

  @override
  Widget build(BuildContext context) {
    final sipBookState = ref.watch(sipBookDetailsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('SIP Book'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: sipBookState.when(
        loading: () => const ListSkeleton(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (result) {
          if (result == null) return const Center(child: Text('No data'));
          if (!result.isSuccess) return Center(child: Text(result.message));
          if (result.items.isEmpty) {
            return const Center(child: Text('No SIP orders found'));
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
              const Expanded(child: _SipBookList()),
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
    final searchQuery = ref.watch(sipBookSearchQueryProvider);

    return Column(
      children: [
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Search by symbol, template, order no...',
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
        const Padding(
          padding: EdgeInsets.all(5),
          child: Text("Click item for more details"),
        ),
      ],
    );
  }
}

class _SipBookList extends ConsumerWidget {
  const _SipBookList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredItems = ref.watch(sipBookSearchItemProvider);

    if (filteredItems.isEmpty) {
      return const Center(child: Text('No matching SIP orders'));
    }

    return ListView.builder(
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        final displayTitle = item.symbol.isNotEmpty ? item.symbol : item.templateName;
        final subtitleDetails = [
          if (item.frequency.isNotEmpty) item.frequency,
          if (item.txnType.isNotEmpty) item.txnType,
          if (item.startDateTime.isNotEmpty) 'Start: ${item.startDateTime}',
        ].join(' • ');

        return ListTile(
          title: Text(
            displayTitle.isNotEmpty ? displayTitle : 'SIP #${item.orderNumber}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subtitleDetails.isNotEmpty ? subtitleDetails : 'Order #${item.orderNumber}',
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (item.amount.isNotEmpty && item.amount != '0.00')
                Text('₹${item.amount}', style: const TextStyle(fontWeight: FontWeight.bold))
              else if (item.totalQuantity.isNotEmpty && item.totalQuantity != '0')
                Text('Qty: ${item.totalQuantity}', style: const TextStyle(fontWeight: FontWeight.bold))
              else
                Text('Order #${item.orderNumber}', style: const TextStyle(fontSize: 12)),
              if (item.status.isNotEmpty)
                Text(item.status, style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
          onTap: () {
            context.pushNamed('sipBookDetail', extra: item);
          },
        );
      },
    );
  }
}

