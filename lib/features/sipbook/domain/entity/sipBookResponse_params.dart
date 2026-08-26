class SipBookResponseParams {
  final String status;
  final String errorCode;
  final String message;
  final String iv;
  final String data;
  final List<SipBookItem> items;

  const SipBookResponseParams({
    required this.status,
    required this.errorCode,
    required this.message,
    required this.iv,
    required this.data,
    this.items = const [],
  });

  bool get isSuccess => status.toLowerCase().trim() == 'success';

  SipBookResponseParams copyWithDecrypted({
    required List<SipBookItem> items,
  }) {
    return SipBookResponseParams(
      status: status,
      errorCode: errorCode,
      message: message,
      iv: iv,
      data: data,
      items: items,
    );
  }
}

class SipBookItem {
  final String serialNo;
  final String clientId;
  final String orderNumber;
  final String exchange;
  final String orderDateTime;
  final String startDateTime;
  final String endDateTime;
  final String frequency;
  final String txnType;
  final String product;
  final String segment;
  final String securityId;
  final String symbol;
  final String period;
  final String totalQuantity;
  final String entityId;
  final String sourceName;
  final String status;
  final String orderValidity;
  final String reasonDescription;
  final String lastTriggerDate;
  final String nextTriggerDate;
  final String panNo;
  final String participantType;
  final String mktProFlag;
  final String mktProValue;
  final String settlor;
  final String goodTillDaysFlag;
  final String encashFlag;
  final String amount;
  final String orderType;
  final String r;
  final String templateName;

  const SipBookItem({
    required this.serialNo,
    required this.clientId,
    required this.orderNumber,
    required this.exchange,
    required this.orderDateTime,
    required this.startDateTime,
    required this.endDateTime,
    required this.frequency,
    required this.txnType,
    required this.product,
    required this.segment,
    required this.securityId,
    required this.symbol,
    required this.period,
    required this.totalQuantity,
    required this.entityId,
    required this.sourceName,
    required this.status,
    required this.orderValidity,
    required this.reasonDescription,
    required this.lastTriggerDate,
    required this.nextTriggerDate,
    required this.panNo,
    required this.participantType,
    required this.mktProFlag,
    required this.mktProValue,
    required this.settlor,
    required this.goodTillDaysFlag,
    required this.encashFlag,
    required this.amount,
    required this.orderType,
    required this.r,
    required this.templateName,
  });
}

