import 'package:flutter/material.dart';
import '../../../../core/widgets/ListSkeleton.dart';
import '../../domain/entity/sipBookResponse_params.dart';

class SipBookDetailScreen extends StatelessWidget {
  final SipBookItem? item;
  final bool isLoading;

  const SipBookDetailScreen({this.item, this.isLoading = false, super.key});

  @override
  Widget build(BuildContext context) {
    if (isLoading || item == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('SIP Details'),
          backgroundColor: Theme.of(context).colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          shadowColor: Colors.transparent,
          scrolledUnderElevation: 0,
        ),
        body: const DetailSkeleton(),
      );
    }

    final sipItem = item!;
    final title = sipItem.symbol.isNotEmpty ? sipItem.symbol : sipItem.templateName;

    return Scaffold(
      appBar: AppBar(
        title: Text(title.isNotEmpty ? title : 'SIP Details'),
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        scrolledUnderElevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionHeader('SIP & Scrip Info'),
          _detailRow('Symbol', sipItem.symbol),
          _detailRow('Template Name', sipItem.templateName),
          _detailRow('Exchange', sipItem.exchange),
          _detailRow('Segment', sipItem.segment),
          _detailRow('Security ID', sipItem.securityId),
          _detailRow('Product', sipItem.product),
          _detailRow('Txn Type', sipItem.txnType),
          _detailRow('Frequency', sipItem.frequency),

          const SizedBox(height: 16),
          _sectionHeader('Schedule Info'),
          _detailRow('Order Date', sipItem.orderDateTime),
          _detailRow('Start Date', sipItem.startDateTime),
          _detailRow('End Date', sipItem.endDateTime),
          _detailRow('Period', sipItem.period),
          _detailRow('Order Validity', sipItem.orderValidity),
          _detailRow('Last Trigger Date', sipItem.lastTriggerDate),
          _detailRow('Next Trigger Date', sipItem.nextTriggerDate),

          const SizedBox(height: 16),
          _sectionHeader('Amount & Quantity'),
          _detailRow('Amount', sipItem.amount),
          _detailRow('Total Quantity', sipItem.totalQuantity),
          _detailRow('Order Type', sipItem.orderType),
          _detailRow('Mkt Pro Flag', sipItem.mktProFlag),
          _detailRow('Mkt Pro Value', sipItem.mktProValue),

          const SizedBox(height: 16),
          _sectionHeader('Order & Account Info'),
          _detailRow('Serial No', sipItem.serialNo),
          _detailRow('Order Number', sipItem.orderNumber),
          _detailRow('Status', sipItem.status),
          _detailRow('Client ID', sipItem.clientId),
          _detailRow('Entity ID', sipItem.entityId),
          _detailRow('Source Name', sipItem.sourceName),
          _detailRow('PAN No', sipItem.panNo),
          _detailRow('Participant Type', sipItem.participantType),
          _detailRow('Settlor', sipItem.settlor),
          _detailRow('Good Till Days', sipItem.goodTillDaysFlag),
          _detailRow('Encash Flag', sipItem.encashFlag),

          if (sipItem.reasonDescription.isNotEmpty && sipItem.reasonDescription != '----') ...[
            const SizedBox(height: 16),
            _sectionHeader('Remarks'),
            _detailRow('Reason', sipItem.reasonDescription),
          ],
        ],
    ));
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
            child: Text(value.trim().isEmpty ? '-' : value),
          ),
        ],
      ),
    );
  }
}

