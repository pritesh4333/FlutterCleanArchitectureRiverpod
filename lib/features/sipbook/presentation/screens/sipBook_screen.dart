import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:stockholding/core/widgets/CommanWidgets.dart';
import '../../../../core/theam/app_fonts.dart';
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
      body: sipBookState.when(
        loading: () => const ListSkeleton(),
        error: (e, _) => Center(child: CommonText('Error: $e',fontFamily: AppFonts.fontName,
          fontWeight: FontWeight.w200, // 👈 bold — maps to RethinkSans-Bold.ttf
          fontSize: 15,
          color: Colors.black,)),
        data: (result) {
          if (result == null) return const Center(child: CommonText('No data',fontFamily: AppFonts.fontName,
            fontWeight: FontWeight.w200, // 👈 bold — maps to RethinkSans-Bold.ttf
            fontSize: 15,
            color: Colors.black,));
          if (!result.isSuccess) return Center(child: CommonText(result.message,fontFamily: AppFonts.fontName,
            fontWeight: FontWeight.w200, // 👈 bold — maps to RethinkSans-Bold.ttf
            fontSize: 15,
            color: Colors.black,));
          if (result.items.isEmpty) {
            return const Center(child: CommonText('No SIP orders found',fontFamily: AppFonts.fontName,
              fontWeight: FontWeight.w200, // 👈 bold — maps to RethinkSans-Bold.ttf
              fontSize: 15,
              color: Colors.black,));
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

        CommonTextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Search by symbol, template, order no...',
            border: const OutlineInputBorder(),
            suffixIcon: searchQuery.isEmpty
                ? null
                : IconButton(icon: const Icon(Icons.clear), onPressed: onClear),
          ),
          onChanged: onChanged,
          fontSize: 15,
          fontWeight: FontWeight.w200,
          color: Colors.black,
          fontFamily: AppFonts.fontName,
        ),
        const Padding(
          padding: EdgeInsets.all(5),
          child: CommonText("Click item for more details",fontFamily: AppFonts.fontName,
            fontWeight: FontWeight.w200, // 👈 bold — maps to RethinkSans-Bold.ttf
            fontSize: 15,
            color: Colors.black,),
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
      return const Center(child: CommonText('No matching SIP orders',fontFamily: AppFonts.fontName,
        fontWeight: FontWeight.w200, // 👈 bold — maps to RethinkSans-Bold.ttf
        fontSize: 15,
        color: Colors.black,));
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
          title: CommonText(
            displayTitle.isNotEmpty ? displayTitle : 'SIP #${item.orderNumber}',fontFamily: AppFonts.fontName,
            fontWeight: FontWeight.w200, // 👈 bold — maps to RethinkSans-Bold.ttf
            fontSize: 15,
            color: Colors.black,
          ),
          subtitle: CommonText(
            subtitleDetails.isNotEmpty ? subtitleDetails : 'Order #${item.orderNumber}',fontFamily: AppFonts.fontName,
            fontWeight: FontWeight.w200, // 👈 bold — maps to RethinkSans-Bold.ttf
            fontSize: 15,
            color: Colors.black,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (item.amount.isNotEmpty && item.amount != '0.00')
                CommonText('₹${item.amount}',fontFamily: AppFonts.fontName,
                  fontWeight: FontWeight.w200, // 👈 bold — maps to RethinkSans-Bold.ttf
                  fontSize: 15,
                  color: Colors.black,)
              else if (item.totalQuantity.isNotEmpty && item.totalQuantity != '0')
                CommonText('Qty: ${item.totalQuantity}',fontFamily: AppFonts.fontName,
                  fontWeight: FontWeight.w200, // 👈 bold — maps to RethinkSans-Bold.ttf
                  fontSize: 15,
                  color: Colors.black,)
              else
                CommonText('Order #${item.orderNumber}',fontFamily: AppFonts.fontName,
                    fontWeight: FontWeight.w200, // 👈 bold — maps to RethinkSans-Bold.ttf
                    fontSize: 15,
                    color: Colors.black,),
              if (item.status.isNotEmpty)
                CommonText(item.status,fontFamily: AppFonts.fontName,
                  fontWeight: FontWeight.w200, // 👈 bold — maps to RethinkSans-Bold.ttf
                  fontSize: 15,
                  color: Colors.black,),
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

