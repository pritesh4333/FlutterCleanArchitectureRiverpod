import 'package:flutter/material.dart';
import '../../domain/entity/orderBookResponse_parmams.dart';

class OrderBookDetailScreen extends StatelessWidget {
  final OrderBookItem item;

  const OrderBookDetailScreen({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item.symbol),
        backgroundColor: Theme.of(context).colorScheme.surface, // pin explicitly
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        scrolledUnderElevation: 0, // prevents elevation change on scroll
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionHeader('Instrument'),
          _detailRow('Symbol', item.symbol),
          _detailRow('Exchange', item.exchange),
          _detailRow('Instrument', item.instrument),
          _detailRow('Segment', item.segment),
          _detailRow('Series', item.series),
          _detailRow('ISIN', item.isin),

          const SizedBox(height: 16),
          _sectionHeader('Order Info'),
          _detailRow('Order No', item.orderNo),
          _detailRow('Exchange Order No', item.exchOrderNo),
          _detailRow('Status', item.status),
          _detailRow('Txn Type', item.txnType),
          _detailRow('Order Type', item.orderType),
          _detailRow('Product', item.productName),
          _detailRow('Validity', item.validity),
          _detailRow('Order Date/Time', item.orderDateTime),
          _detailRow('Last Updated', item.lastUpdatedTime),
          _detailRow('Exchange Order Time', item.exchOrderTime),

          const SizedBox(height: 16),
          _sectionHeader('Quantity & Price'),
          _detailRow('Quantity', item.quantity.toString()),
          _detailRow('Remaining Qty', item.remainingQuantity.toString()),
          _detailRow('Traded Qty', item.tradedQty.toString()),
          _detailRow('Disclosed Qty', item.discQuantity.toString()),
          _detailRow('Lot Size', item.lotSize.toString()),
          _detailRow('Price', item.price.toString()),
          _detailRow('Traded Price', item.tradedPrice),
          _detailRow('Avg Traded Price', item.avgTradedPrice),
          _detailRow('Trigger Price', item.triggerPrice.toString()),
          _detailRow('Order Value', item.orderValue.toString()),

          if (item.reasonDescription.isNotEmpty) ...[
            const SizedBox(height: 16),
            _sectionHeader('Remarks'),
            _detailRow('Reason', item.reasonDescription),
            if (item.remarks1.isNotEmpty) _detailRow('Remarks 1', item.remarks1),
            if (item.remarks2.isNotEmpty) _detailRow('Remarks 2', item.remarks2),
          ],
        ],
      ),
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