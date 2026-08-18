class OrderBookResponseParams {
  final String status;
  final String errorCode;
  final String message;
  final String iv;
  final String data; // raw encrypted string, kept for reference/debugging

  /// Populated by the presentation/datasource after decrypting `data`.
  /// Empty until that happens (or on failure).
  final List<OrderBookItem> items;

  const OrderBookResponseParams({
    required this.status,
    required this.errorCode,
    required this.message,
    required this.iv,
    required this.data,
    this.items = const [],
  });

  bool get isSuccess => status.toLowerCase().trim() == 'success';

  OrderBookResponseParams copyWithDecrypted({
    required List<OrderBookItem> items,
  }) {
    return OrderBookResponseParams(
      status: status,
      errorCode: errorCode,
      message: message,
      iv: iv,
      data: data,
      items: items,
    );
  }
}
class OrderBookItem {
  String clientId;
  String orderDateTime;
  String lastUpdatedTime;
  String exchOrderTime;
  String juliDateTime;
  String juliLastUpdateTime;
  String orderNo;
  String exchange;
  String tradedPrice;
  String avgTradedPrice;
  String txnType;
  String segment;
  String instrument;
  String symbol;
  int legNo;
  String product;
  String productName;
  String status;
  int quantity;
  int remainingQuantity;
  double price;
  int triggerPrice;
  String orderType;
  String remQtyTotQty;
  int discQuantity;
  int serialNo;
  int tradedQty;
  String securityId;
  String validity;
  int lotSize;
  int takeProfitTrailGap;
  String algoOrdNo;
  int dqQtyRem;
  String exchOrderNo;
  String reasonDescription;
  String groupId;
  int trailingSlValue;
  int slAbstickValue;
  int prAbstickValue;
  String offMktFlag;
  String childLegUnqId;
  String panNo;
  String participantType;
  String mktProFlag;
  int mktProValue;
  String settlor;
  String gtcFlag;
  String encashFlag;
  String mktType;
  int strikePrice;
  String expiryDate;
  String optType;
  String displayName;
  String isin;
  String series;
  String exchangeInstName;
  String errorCode;
  String source;
  String goodTillDaysDate;
  String placedByEntityId;
  double orderValue;
  String sourceName;
  String uccId;
  int refLtp;
  int tickSize;
  String algoId;
  String strategyId;
  String placedByType;
  String remarks1;
  String remarks2;
  String expiryFlag;
  String omsAlgoOrdNo;
  String lastActTs;

  OrderBookItem({
    required this.clientId,
    required this.orderDateTime,
    required this.lastUpdatedTime,
    required this.exchOrderTime,
    required this.juliDateTime,
    required this.juliLastUpdateTime,
    required this.orderNo,
    required this.exchange,
    required this.tradedPrice,
    required this.avgTradedPrice,
    required this.txnType,
    required this.segment,
    required this.instrument,
    required this.symbol,
    required this.legNo,
    required this.product,
    required this.productName,
    required this.status,
    required this.quantity,
    required this.remainingQuantity,
    required this.price,
    required this.triggerPrice,
    required this.orderType,
    required this.remQtyTotQty,
    required this.discQuantity,
    required this.serialNo,
    required this.tradedQty,
    required this.securityId,
    required this.validity,
    required this.lotSize,
    required this.takeProfitTrailGap,
    required this.algoOrdNo,
    required this.dqQtyRem,
    required this.exchOrderNo,
    required this.reasonDescription,
    required this.groupId,
    required this.trailingSlValue,
    required this.slAbstickValue,
    required this.prAbstickValue,
    required this.offMktFlag,
    required this.childLegUnqId,
    required this.panNo,
    required this.participantType,
    required this.mktProFlag,
    required this.mktProValue,
    required this.settlor,
    required this.gtcFlag,
    required this.encashFlag,
    required this.mktType,
    required this.strikePrice,
    required this.expiryDate,
    required this.optType,
    required this.displayName,
    required this.isin,
    required this.series,
    required this.exchangeInstName,
    required this.errorCode,
    required this.source,
    required this.goodTillDaysDate,
    required this.placedByEntityId,
    required this.orderValue,
    required this.sourceName,
    required this.uccId,
    required this.refLtp,
    required this.tickSize,
    required this.algoId,
    required this.strategyId,
    required this.placedByType,
    required this.remarks1,
    required this.remarks2,
    required this.expiryFlag,
    required this.omsAlgoOrdNo,
    required this.lastActTs,
  });

}
