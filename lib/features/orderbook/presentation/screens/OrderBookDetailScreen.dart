import 'package:flutter/material.dart';
import '../../../../core/widgets/ListSkeleton.dart';
import '../../domain/entity/orderBookResponse_parmams.dart';

class OrderBookDetailScreen extends StatelessWidget {
  final OrderBookItem? item;
  final bool isLoading;

  const OrderBookDetailScreen({this.item, this.isLoading = false, super.key});

  @override
  Widget build(BuildContext context) {
    if (isLoading || item == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Order Details'),
          backgroundColor: Theme.of(context).colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          scrolledUnderElevation: 0,
        ),
        body: const DetailSkeleton(),
      );
    }

    final orderItem = item!;

    return Scaffold(
      appBar: AppBar(
        title: Text(orderItem.symbol),
        backgroundColor: Theme.of(context).colorScheme.surface, // pin explicitly
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        scrolledUnderElevation: 0, // prevents elevation change on scroll
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionHeader('Instrument'),
          _detailRow('Symbol', orderItem.symbol),
          _detailRow('Exchange', orderItem.exchange),
          _detailRow('Instrument', orderItem.instrument),
          _detailRow('Segment', orderItem.segment),
          _detailRow('Series', orderItem.series),
          _detailRow('ISIN', orderItem.isin),

          const SizedBox(height: 16),
          _sectionHeader('Order Info'),
          _detailRow('Order No', orderItem.orderNo),
          _detailRow('Exchange Order No', orderItem.exchOrderNo),
          _detailRow('Status', orderItem.status),
          _detailRow('Txn Type', orderItem.txnType),
          _detailRow('Order Type', orderItem.orderType),
          _detailRow('Product', orderItem.productName),
          _detailRow('Validity', orderItem.validity),
          _detailRow('Order Date/Time', orderItem.orderDateTime),
          _detailRow('Last Updated', orderItem.lastUpdatedTime),
          _detailRow('Exchange Order Time', orderItem.exchOrderTime),

          const SizedBox(height: 16),
          _sectionHeader('Quantity & Price'),
          _detailRow('Quantity', orderItem.quantity.toString()),
          _detailRow('Remaining Qty', orderItem.remainingQuantity.toString()),
          _detailRow('Traded Qty', orderItem.tradedQty.toString()),
          _detailRow('Disclosed Qty', orderItem.discQuantity.toString()),
          _detailRow('Lot Size', orderItem.lotSize.toString()),
          _detailRow('Price', orderItem.price.toString()),
          _detailRow('Traded Price', orderItem.tradedPrice),
          _detailRow('Avg Traded Price', orderItem.avgTradedPrice),
          _detailRow('Trigger Price', orderItem.triggerPrice.toString()),
          _detailRow('Order Value', orderItem.orderValue.toString()),

          if (orderItem.reasonDescription.isNotEmpty) ...[
            const SizedBox(height: 16),
            _sectionHeader('Remarks'),
            _detailRow('Reason', orderItem.reasonDescription),
            if (orderItem.remarks1.isNotEmpty) _detailRow('Remarks 1', orderItem.remarks1),
            if (orderItem.remarks2.isNotEmpty) _detailRow('Remarks 2', orderItem.remarks2),
          ],
        ],
      )
      );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(value.isEmpty ? '-' : value),
          ),
        ],
      ),
    );
  }
}